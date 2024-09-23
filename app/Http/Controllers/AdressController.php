<?php

namespace App\Http\Controllers;

use App\Models\adress;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AdressController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = adress::orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $addresses = $query->paginate(18);

            return response()->json([
                'data' => $addresses->items(), // جلب العناصر الحالية فقط
                'current_page' => $addresses->currentPage(),
                'last_page' => $addresses->lastPage(),
                'total' => $addresses->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
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
                'full_address' => 'required',
                'status' => 'nullable',
                'user_id' => 'required',
                'account_type' => 'required',
            ]);
            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $adress = new adress();
            $adress->status = $request->status;
            $adress->full_address = $request->full_address;
            $adress->latitude = $request->latitude;
            $adress->longitude = $request->longitude;
            $adress->user_id = $request->user_id;
            $adress->account_type = $request->account_type;

            $adress->save();
            return response()->json([
                'data' => $adress
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getAddressesCountByUserId($user_id, $account_type)
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $addressCount = Adress::where('user_id', $user_id)
                ->where('account_type', $account_type)
                ->count();

            return response()->json([
                'total_addresses' => $addressCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getAddressesByUserId($user_id, $account_type)
    {
        try {
            // جلب العناوين بناءً على نوع الحساب
            $addresses = Adress::where('user_id', $user_id)
                ->where('account_type', $account_type)
                ->get();

            return response()->json([
                'data' => $addresses
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
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
                'full_address' => 'sometimes|string|max:255',
                'status' => 'required|in:active,inactive', // مثال على التحقق من حالة العنوان
            ]);
            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------
            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $findadress = adress::findOrFail($id);

            $filds = ['full_address', 'status'];
            // -----------------------------------
            // update columns   ----
            // -----------------------------------
            foreach ($filds as $fild) {
                if ($request->has($fild)) {
                    $findadress->$fild = $request->$fild;
                };
            };

            $findadress->save();

            return response()->json([
                'data' => $findadress
            ]);
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
            // -----------------------------------
            // delete address   ----
            // -----------------------------------
            $adress = adress::findOrFail($id);
            if ($adress) {
                $adress->delete();
            };
            return response()->json([
                'address' => 'Address is deleted'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }
}
