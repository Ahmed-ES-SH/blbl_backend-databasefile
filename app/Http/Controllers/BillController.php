<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Bill;
use Illuminate\Support\Facades\DB;

class BillController extends Controller
{
    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = Bill::with('user')->orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $Bills = $query->paginate(18);

            return response()->json([
                'data' => $Bills->items(), // جلب العناصر الحالية فقط
                'current_page' => $Bills->currentPage(),
                'last_page' => $Bills->lastPage(),
                'total' => $Bills->total(),
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $Bill = Bill::findOrFail($id);
            $Bill->delete();
            return response()->json([
                'message' => 'Bill deleted successfuly'
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getBillsSummary()
    {
        // جلب الفواتير لكل مستخدم وتجميعها وترتيبها بناءً على إجمالي الفواتير
        $bills = Bill::with('user') // جلب علاقة المستخدم مع الفاتورة
            ->select('user_id', DB::raw('SUM(bill_value) as total_amount'))
            ->groupBy('user_id')
            ->orderBy('total_amount', 'desc') // ترتيب تنازلي حسب الإجمالي
            ->get();

        return response()->json(['data' => $bills], 200);
    }
}
