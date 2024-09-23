<?php

namespace App\Http\Controllers;

use App\Models\ordermoney;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrdermoneyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = ordermoney::with('vendor')->orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $ordersmoney = $query->paginate(18);

            return response()->json([
                'data' => $ordersmoney->items(), // جلب العناصر الحالية فقط
                'current_page' => $ordersmoney->currentPage(),
                'last_page' => $ordersmoney->lastPage(),
                'total' => $ordersmoney->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
    public function show($id)
    {
        try {
            // العثور على ordermoney مع علاقته بالـ vendor
            $ordermoney = Ordermoney::with('vendor')->findOrFail($id);

            // إرجاع البيانات في حالة النجاح
            return response()->json([
                'data' => $ordermoney,
            ], 200);
        } catch (\Exception $e) {
            // إرجاع رسالة الخطأ في حالة وجود مشكلة
            return response()->json([
                'message' => 'Error retrieving ordermoney: ' . $e->getMessage(),
            ], 500);
        }
    }




    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            // التحقق من صحة البيانات
            $validation = Validator::make($request->all(), [
                'paypalaccount' => 'required|string|max:255', // إضافة قيود على البيانات
                'amount' => 'required|numeric|min:0', // التحقق من أن المبلغ رقم موجب
            ]);

            // التحقق من فشل التحقق
            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422); // حالة HTTP 422 عند فشل التحقق من البيانات
            }

            // إنشاء سجل جديد
            $ordermoney = new Ordermoney();
            $ordermoney->vendor_id = $request->vendor_id;
            $ordermoney->paypalaccount = $request->paypalaccount;
            $ordermoney->amount = $request->amount;
            $ordermoney->save();

            // استجابة النجاح
            return response()->json([
                'data' => $ordermoney,
                'message' => 'Order money created successfully'
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }



    public function update(Request $request, $id)
    {
        try {
            // التحقق من صحة المدخلات
            $validation = Validator::make($request->all(), [
                'vendor_id' => 'required|exists:vendors,id', // التحقق من وجود vendor_id في جدول البائعين
                'updated_balance' => 'required|numeric', // التأكد أن الرصيد هو رقم
                'order_status' => 'required'
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'error' => $validation->errors(),
                ], 422); // استخدام 422 كرمز لخطأ التحقق من صحة المدخلات
            }

            // جلب ordermoney
            $ordermoney = Ordermoney::findOrFail($id);

            // تحديث حالة الطلب إذا كانت موجودة في الطلب
            if ($request->has('order_status')) {
                $ordermoney->order_status = $request->order_status;
            }

            // جلب البائع وتحديث الرصيد
            $vendor = Vendor::findOrFail($request->vendor_id);
            $vendor->balance = $request->updated_balance;
            $vendor->save(); // حفظ بيانات البائع بعد تحديث الرصيد

            // حفظ ordermoney بعد تحديث الحالة (إن وجدت)
            $ordermoney->save();

            // إرجاع البيانات المحدثة
            return response()->json([
                'data' => $ordermoney,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error updating order: ' . $e->getMessage(),
            ], 500);
        }
    }




    /**
     * Remove the specified resource from storage.
     */
    public function destroy($ordermoney_id)
    {
        try {
            $ordermoney = ordermoney::findOrFail($ordermoney_id);
            $ordermoney->delete();
            return response()->json([
                'message' => 'The Order deleted successfuly'
            ], 200);
        } catch (\Exception  $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
