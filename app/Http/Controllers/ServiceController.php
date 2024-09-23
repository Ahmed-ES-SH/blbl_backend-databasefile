<?php

namespace App\Http\Controllers;

use App\Models\service;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class ServiceController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     */

    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = service::orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $services = $query->paginate(18);

            return response()->json([
                'data' => $services->items(), // جلب العناصر الحالية فقط
                'current_page' => $services->currentPage(),
                'last_page' => $services->lastPage(),
                'total' => $services->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getServicesCount()
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $ServicesCount = service::count();
            return response()->json([
                'data' => $ServicesCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function publishedservices()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = service::with('vendor')
                ->where('status', 'published') // إضافة شرط تصفية status
                ->orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $services = $query->paginate(18);

            return response()->json([
                'data' => $services->items(), // جلب العناصر الحالية فقط
                'current_page' => $services->currentPage(),
                'last_page' => $services->lastPage(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function searchforservicebyname(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validation = Validator::make($request->all(), [
                'titlesearch' => 'required'
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            // بناء الاستعلام مع تطبيق البحث إذا تم تقديمه
            $query = service::with('vendor')
                ->where('title', 'like', '%' . $request->titlesearch . '%')
                ->where('status', 'published')
                ->orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $services = $query->paginate(18);

            return response()->json([
                'data' => $services->items(), // جلب العناصر الحالية فقط
                'current_page' => $services->currentPage(),
                'last_page' => $services->lastPage(),
                'total' => $services->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function get10randomservices()
    {
        try {
            // -------------------------
            // return 10 random services ---
            // -------------------------
            $services = service::with('vendor')
                ->where('status', 'published')
                ->select('id', 'vendor_id', 'title', 'coast', 'rating')
                ->inRandomOrder()->take(10)->get();
            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }

    public function get10randomservices_with_title_and_image_only()
    {
        try {
            // -------------------------
            // return 10 random services ---
            // -------------------------
            $services = service::inRandomOrder()
                ->take(10)
                ->select('id', 'title', 'image')
                ->get();
            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }
    public function get4randomservices_with_custom_details()
    {
        try {
            // -------------------------
            // return 10 random services ---
            // -------------------------
            $services = service::with('vendor')
                ->where('status', 'published')
                ->inRandomOrder()
                ->take(4)
                ->select('id', 'vendor_id', 'title', 'image', 'description', 'coast')
                ->get();
            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }
    public function get_top10_services()
    {
        try {
            // -------------------------
            // return 10 random services ---
            // -------------------------
            $services = service::with('vendor')
                ->orderBy('rating')
                ->take(10)
                ->get();
            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'title' => 'required|min:4|max:30',
                'description' => 'required|min:6|max:30',
                'vendor_id' => 'required',
                'image' => 'nullable|file|image|mimes:jpeg,png,jpg,gif',
                'extra_services' => 'nullable',
                'key_words' => 'nullable|array',
                'rating' => 'nullable',
                'start_price' => 'nullable|numeric',
                'end_price' => 'nullable|numeric',
                'coast' => 'required|numeric'
            ]);
            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }
            // -------------------------
            // Add data to colums   ----
            // -------------------------

            $service = new service();
            $service->title = $request->title;
            $service->description = $request->description;
            $service->vendor_id = $request->vendor_id;
            $service->servicetype_id = $request->servicetype_id;
            $service->extra_services = $request->extra_services;
            $service->key_words = $request->key_words; // تخزين المهارات والخبرات كمصفوفة JSON
            $service->rating = $request->rating;
            $service->start_price = $request->start_price;
            $service->end_price = $request->end_price;
            $service->coast = $request->coast;
            // -------------------------
            // Add Image url    ----
            // -------------------------

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = date('Ymd-His') . '.' . $file->getClientOriginalExtension();
                $PathserviserviceImage = 'images/services';
                $file->move(public_path($PathserviserviceImage), $filename);
                $service->image = url('/') . '/'. 'public/' . $PathserviserviceImage . '/' . $filename;
            }
            // ----------------------------------
            // should be save data in end    ----
            // ----------------------------------
            $service->save();

            return response()->json([
                'Message' => 'Add service Success',
                'data' => $service
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        try {
            // ---------------------------------
            // جلب خدمة واحدة بناءً على المعرف (ID) مع العلاقة مع التاجر
            // ----------------------------------
            $service = service::with('vendor')->findOrFail($id);

            return response()->json([
                'data' => $service
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'الخدمة غير موجودة',
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ أثناء جلب الخدمة: ' . $e->getMessage(),
            ], 500);
        }
    }


    public function getServicesByIdVendor($id)
    {
        try {
            $vendor = vendor::findOrFail($id);

            $services = $vendor->services;

            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'title' => 'sometimes|min:6|max:30',
                'image' => 'nullable|file|image|mimes:jpeg,png,jpg,gif',
                'extra_services' => 'sometimes',
                'key_words' => 'sometimes|array',
                'rating' => 'nullable',
                'start_price' => 'sometimes|numeric',
                'end_price' => 'sometimes|numeric',
                'coast' => 'sometimes|numeric'
            ]);
            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }
            $service = service::findOrFail($id);

            $filds = [
                'title',
                'extra_services',
                'key_words',
                'rating',
                'start_price',
                'end_price',
                'coast'
            ];
            foreach ($filds as $fild) {
                if ($request->has($fild)) {
                    $service->$fild = $request->$fild;
                };
            };

            $service->status = 'pending';
            // -------------------------
            // delete old image   ----
            // -------------------------
            if ($request->hasFile('image')) {
                $old_image = $service->image;
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/vendors';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
                // -------------------------
                // update new image   ----
                // -------------------------
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $file->move(public_path($path), $filename);
                $service->image = url('/') . '/'. 'public/' . $path . '/' . $filename;
            }
            $service->save();
            return response()->json([
                'data' => $service
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }


    public function update_status(Request $request, $id)
    {
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'status' => 'required',

            ]);
            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }
            $service = service::findOrFail($id);
            $service->status = $request->status;

            $service->save();

            return response()->json([
                'message' => 'Service status  are updated',
                'data' => $service
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $service = service::findOrFail($id);
            // -------------------------
            // delete old image   ----
            // -------------------------
            $old_image = $service->image;
            if ($old_image) {
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/services';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
            }

            // -------------------------
            // delete service    -------
            // -------------------------
            $service->delete();

            return response()->json([
                'message' => 'service deleted successfully'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        };
    }
}
