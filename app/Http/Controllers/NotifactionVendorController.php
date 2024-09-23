<?php

namespace App\Http\Controllers;

use App\Models\Notifaction;
use App\Models\NotifactionVendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NotifactionVendorController extends Controller
{

    public function NotifactionsByVendorId($vendor_id)
    {
        try {
            $notifactions = NotifactionVendor::where('vendor_id', $vendor_id)->get();
            return response()->json([
                'data' => $notifactions
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
        $validation = Validator::make($request->all(), [
            'vendor_id' => 'required|exists:vendors,id',
            'message' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        try {

            $notifaction = new NotifactionVendor();
            $notifaction->vendor_id = $request->vendor_id;
            $notifaction->message = $request->message;
            $notifaction->save();
            return response()->json([
                'data' => $notifaction
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
            $notifaction = NotifactionVendor::findOrFail($id);
            return response()->json([
                'data' => $notifaction
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
        $validation = Validator::make($request->all(), [
            'message' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        try {

            $notifaction =  NotifactionVendor::findOrFail($id);
            $notifaction->message = $request->message;
            $notifaction->save();
            return response()->json([
                'data' => $notifaction
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function markAsRead($id)
    {
        try {
            // الحصول على جميع الإشعارات الخاصة بالمستخدم بناءً على الـ id
            $notifications = NotifactionVendor::where('vendor_id', $id)->get();

            // تكرار لحفظ كل إشعار بعد تعيينه كمقروء
            foreach ($notifications as $notification) {
                $notification->read = true;
                $notification->save(); // حفظ كل نموذج بشكل فردي
            }

            return response()->json([
                'message' => 'Notification marked as read successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get unread notifications by Vendor ID.
     */
    public function getUnreadNotificationsByVendorId($vendor_id)
    {
        try {
            $notifications = NotifactionVendor::where('vendor_id', $vendor_id)
                ->where('read', false)
                ->get();
            return response()->json([
                'data' => $notifications
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $notifaction = NotifactionVendor::findOrFail($id);
            $notifaction->delete();
            return response()->json([
                'message' => 'notification deleted successfuly'
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
