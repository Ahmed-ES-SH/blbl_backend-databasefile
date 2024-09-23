<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class UsersController extends Controller
{

    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = User::orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $users = $query->paginate(18);

            return response()->json([
                'data' => $users->items(), // جلب العناصر الحالية فقط
                'current_page' => $users->currentPage(),
                'last_page' => $users->lastPage(),
                'total' => $users->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getUsersCount()
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $UsersCount = User::count();
            return response()->json([
                'data' => $UsersCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    //search for user and return all data 

    public function searchUserByName(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'name' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        try {
            $users = User::where('name', 'like', '%' . $request->name . '%')
                ->get();
            return response()->json([
                'data' => $users
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
    //search for user and return { name , id } only for notifactions

    public function searchUserByNamefornotifactions(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'name' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        try {
            $users = User::where('name', 'like', '%' . $request->name . '%')
                ->select('id', 'name')
                ->get();


            if ($users->isEmpty()) {
                return response()->json([
                    'message' => 'No vendors found with the given name.'
                ], 422); // Use 404 Not Found for no matching records
            }


            return response()->json([
                'data' => $users
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }





    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        try {
            $user = User::findOrFail($id);
            return response()->json([
                'data' => $user,
                'success' => true
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }




    public function update(Request $request, $id)
    {
        try {

            $user = User::findOrFail($id);


            $valitaion = Validator::make($request->all(), [
                'name' => 'sometimes|string|max:255',
                'role' => 'sometimes|string',
                'location' => 'sometimes|string',
                'email' => 'sometimes|email|max:255|unique:users,email,' . $id,
                'phone_number' => 'sometimes|nullable|string|max:15|min:10',
                'image' => 'nullable', // التحقق من صحة الصورة
            ]);

            if ($valitaion->fails()) {
                return response()->json([
                    'errors' => $valitaion->errors()
                ], 422);
            }

            // -------------------------
            //   update user data ----
            // -------------------------

            if ($request->has('name')) {
                $user->name = $request->name;
            };
            if ($request->has('role')) {
                $user->role = $request->role;
            };
            if ($request->has('email')) {
                $user->email = $request->email;
            };
            if ($request->has('phone_number')) {
                $user->phone_number = $request->phone_number;
            };
            if ($request->has('location')) {
                $user->location = $request->location;
            };


            if ($request->hasFile('image')) {
                // -------------------------
                // delete old image   ----
                // -------------------------
                $old_image = $user->image;

                if ($old_image) {
                    $old_image_name = basename(parse_url($old_image, PHP_URL_PATH));
                    $file_path = public_path('images/users', $old_image_name);
                    if (File::exists($file_path)) {
                        File::delete($file_path);
                    };
                };
                // -------------------------
                // update image faild   ----
                // -------------------------
                $image = $request->image;
                $filename = date('YmdHis') . '.' . $image->getClientOriginalExtension();
                $path = 'images/users';
                $image->move(public_path($path), $filename);
                $user->image = url('/') . '/' . 'public/' . $path . '/' . $filename;
            };

            $user->save();

            return response()->json([
                'data' => $user
            ], 200);
        } catch (\Exception $e) {

            return response()->json([
                'error' => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $user = User::findOrFail($id);
            // -------------------------
            // delete old image   ----
            // -------------------------
            $image = $user->image;
            $imagename = basename(parse_url($image, PHP_URL_PATH));
            $imagepath = public_path('images/users', $imagename);
            if (File::exists($imagepath)) {
                File::delete($imagepath);
            };

            $user->delete();
            return response()->json([
                'messsage' => 'User deleted sucess'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    public function currentUser()
    {
        try {
            // محاولة جلب المستخدم باستخدام حارس 'api'
            $user = Auth::guard('api')->user();

            // إذا لم يتم العثور على مستخدم في حارس 'api'، جرب حارس 'vendor'
            if (!$user) {
                $user = Auth::guard('vendor')->user();
            }

            // إذا لم يتم العثور على مستخدم في أي من الحارسين
            if (!$user) {
                return response()->json([
                    'message' => 'Unauthenticated'
                ], 401);
            }

            // التحقق مما إذا كان المستخدم هو بائع
            if ($user instanceof Vendor) {
                return response()->json([
                    'data' => $user,
                    'type' => 'vendor', // تحديد النوع: بائع
                ], 200);
            }

            // إذا لم يكن المستخدم بائعًا، يتم اعتباره مستخدم عادي
            return response()->json([
                'data' => $user,
                'type' => 'user', // تحديد النوع: مستخدم
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
