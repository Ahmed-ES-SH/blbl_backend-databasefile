<?php

namespace App\Http\Controllers;

use App\Models\Customerservice;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Vendor;

class CustomerController extends Controller

{
    /**
     * عرض جميع رسائل خدمة العملاء.
     */


   public function index()
{
    try {
        // ----------------------------
        // get all vendors data   -----
        // ----------------------------
        $messages = Customerservice::with('user')->orderBy('created_at', 'desc')->paginate(18);

        // التحقق إذا كانت البيانات فارغة
        $data = $messages->items();

        return response()->json([
            'data' => $data, // جلب العناصر الحالية فقط
            'current_page' => $messages->currentPage(),
            'last_page' => $messages->lastPage(),
            'total' => $messages->total()
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}

    /**
     * تخزين رسالة جديدة.
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'user_id' => 'required|integer',
            'message' => 'required|string',
            'message_status' => 'in:pending,in_progress,resolved',
        ]);



        // إنشاء الرسالة
        $customerService = Customerservice::create([
            'user_id' => $validatedData['user_id'],
            'message' => $validatedData['message'],
            'message_status' => $validatedData['message_status'] ?? 'pending',
        ]);

        return response()->json(['message' => 'تم إنشاء الرسالة بنجاح', 'data' => $customerService], 201);
    }

    /**
     * عرض رسالة محددة.
     */
    public function show($id)
    {
        $message = Customerservice::with('user')->findOrFail($id); // تحميل الرسالة مع المرسل
        return response()->json($message);
    }

    /**
     * تحديث رسالة.
     */
    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'message' => 'sometimes|required|string',
            'message_status' => 'in:pending,in_progress,resolved',
        ]);

        $customerService = Customerservice::findOrFail($id);
        $customerService->update($validatedData);

        return response()->json(['message' => 'تم تحديث الرسالة بنجاح', 'data' => $customerService]);
    }

    /**
     * حذف رسالة.
     */
    public function destroy($id)
    {
        $customerService = Customerservice::findOrFail($id);
        $customerService->delete();

        return response()->json(['message' => 'تم حذف الرسالة بنجاح']);
    }
}
