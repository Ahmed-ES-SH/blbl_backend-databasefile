<?php

namespace App\Http\Controllers;

use App\Models\CustomerServiceMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Pusher\Pusher;

class CustomerServiceMessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
   public function index($conversation_id, $offset = 0)
{
    $messages = CustomerServiceMessage::where('customerserviceconversation_id', $conversation_id)
        ->latest()
        ->skip($offset)
        ->take(30)
        ->get()
        ->reverse()
        ->values();

    if ($messages->isEmpty()) {
        return response()->json([
            'message' => 'No messages available'
        ], 404);
    }

    return response()->json([
        'data' => $messages
    ]);
}



    public function store(Request $request)
    {
        // التحقق من صحة البيانات
        $validation = Validator::make($request->all(), [
        'customerserviceconversation_id' => 'required|exists:conversations,id',
        'message' => 'nullable|string|max:1000',
        'audio' => 'nullable', // تحقق من نوع وحجم الملف الصوتي
        'image' => 'nullable|mimes:jpg,jpeg,png,webp|max:20480', // تحقق من نوع وحجم الصورة
        'sender_id' => 'required',
        'sender_type' => 'required'
    ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ]);
        }
        
        $audioPath = null;
        $imagePath = null;
        
        
        if ($request->hasFile('audio')) {
        $audioPath = $request->file('audio')->store('audio', 'public');
        }
    
        // إذا كان هناك صورة، قم برفعها وتخزينها
         if ($request->hasFile('image')) {
        $imagePath = $request->file('image')->store('images', 'public');
         }
         
         

        $message = CustomerServiceMessage::create([
        'customerserviceconversation_id' => $request->customerserviceconversation_id,
        'message' => $request->message,
        'audio' => $audioPath, // تخزين المسار الصوتي
        'image' => $imagePath, // تخزين مسار الصورة
        'sender_id' => $request->sender_id,
        'sender_type' => $request->sender_type,
        ]);
        // إعداد Pusher
        $pusher = new Pusher(
            env('PUSHER_APP_KEY'),
            env('PUSHER_APP_SECRET'),
            env('PUSHER_APP_ID'),
            [
                'cluster' => env('PUSHER_APP_CLUSTER'),
                'useTLS' => true,
            ]
        );

       // إرسال البيانات إلى القناة
    $pusher->trigger('chat', 'MessageSent', [
        'message' => $message,
        'sender_id' => $request->sender_id,
        'sender_type' => $request->sender_type
    ]);

        // رد البيانات
        return response()->json([
            'data' => $message
        ]);
    }
    
    
        public function markAllAsRead($customerserviceconversation_id)
{
    try {
        // تحديث جميع الرسائل غير المقروءة في المحادثة المحددة إلى مقروءة
        CustomerServiceMessage::where('customerserviceconversation_id', $customerserviceconversation_id)
            ->where('is_read', 0)
            ->update(['is_read' => 1]);

        return response()->json([
            'message' => 'All unread messages in this conversation have been marked as read.'
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Error: ' . $e->getMessage()
        ], 500);
    }
}
    
}
