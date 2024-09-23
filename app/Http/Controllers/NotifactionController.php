<?php

namespace App\Http\Controllers;

use App\Models\Notifaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NotifactionController extends Controller
{

    public function NotifactionsByUserId($user_id)
    {
        try {
            $notifactions = Notifaction::where('user_id', $user_id)
                ->orderBy('created_at')->get();
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
            'user_id' => 'required|exists:users,id|string',
            'message' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        try {

            $notifaction = new Notifaction();
            $notifaction->user_id = $request->user_id;
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
            $notifaction = Notifaction::findOrFail($id);
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

            $notifaction =  Notifaction::findOrFail($id);
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
            $notifications = Notifaction::where('user_id', $id)->get();

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
     * Get unread notifications by user ID.
     */
    public function getUnreadNotificationsByUserId($user_id)
    {
        try {
            $notifications = Notifaction::where('user_id', $user_id)
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
            $notifaction = Notifaction::findOrFail($id);
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
