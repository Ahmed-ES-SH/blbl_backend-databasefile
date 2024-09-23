<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\Message;
use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ConversationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index($id, $type)
    {
        try {
            // جلب المحادثات التي يكون فيها الحساب الأول أو الثاني هو المستخدم/التاجر المحدد
            $conversations = Conversation::where(function ($query) use ($id, $type) {
                $query->where('first_party_id', $id)
                    ->where('first_party_type', $type);
            })
                ->orWhere(function ($query) use ($id, $type) {
                    $query->where('second_party_id', $id)
                        ->where('second_party_type', $type);
                })
                ->get();

            // إضافة بيانات المستخدمين والتجار للمحادثات
            $conversations = $conversations->map(function ($conversation) {
                // جلب بيانات الطرف الأول
                if ($conversation->first_party_type === 'user') {
                    $conversation->first_party = User::find($conversation->first_party_id);
                } elseif ($conversation->first_party_type === 'vendor') {
                    $conversation->first_party = Vendor::find($conversation->first_party_id);
                }

                // جلب بيانات الطرف الثاني
                if ($conversation->second_party_type === 'user') {
                    $conversation->second_party = User::find($conversation->second_party_id);
                } elseif ($conversation->second_party_type === 'vendor') {
                    $conversation->second_party = Vendor::find($conversation->second_party_id);
                }

                return $conversation;
            });

            return response()->json([
                'data' => $conversations
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }






    public function getConversationsWithUnreadStatus($id, $type)
    {
        try {
            // جلب جميع المحادثات الخاصة بالمستخدم أو التاجر بناءً على نوع الحساب
            $conversations = Conversation::where(function ($query) use ($id, $type) {
                $query->where('first_party_id', $id)
                    ->where('first_party_type', $type);
            })
                ->orWhere(function ($query) use ($id, $type) {
                    $query->where('second_party_id', $id)
                        ->where('second_party_type', $type);
                })
                ->get();

            // إضافة حالة الرسائل الغير مقروءة وجلب بيانات الأطراف بشكل يدوي
            $conversationsWithUnreadStatus = $conversations->map(function ($conversation) {
                // جلب الرسائل المرتبطة بالمحادثة
                $messages = Message::where('conversation_id', $conversation->id)->get();

                // التحقق من وجود رسائل غير مقروءة
                $conversation->hasUnreadMessages = $messages->some(function ($message) {
                    return !$message->is_read;
                });

                // جلب بيانات الطرف الأول
                $firstParty = null;
                if ($conversation->first_party_type === 'user') {
                    $firstParty = User::find($conversation->first_party_id);
                } elseif ($conversation->first_party_type === 'vendor') {
                    $firstParty = Vendor::find($conversation->first_party_id);
                }

                // جلب بيانات الطرف الثاني
                $secondParty = null;
                if ($conversation->second_party_type === 'user') {
                    $secondParty = User::find($conversation->second_party_id);
                } elseif ($conversation->second_party_type === 'vendor') {
                    $secondParty = Vendor::find($conversation->second_party_id);
                }

                // تضمين الأطراف في الاستجابة
                $conversation->first_party = $firstParty;
                $conversation->second_party = $secondParty;

                return $conversation;
            });

            return response()->json([
                'data' => $conversationsWithUnreadStatus
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
            // التحقق من صحة البيانات الواردة
            $validation = Validator::make($request->all(), [
                'first_party_id' => 'required',
                'first_party_type' => 'required|in:user,vendor', // نوع الطرف الأول (مستخدم أو تاجر)
                'second_party_id' => 'required',
                'second_party_type' => 'required|in:user,vendor', // نوع الطرف الثاني (مستخدم أو تاجر)
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            // تحديد نوع المحادثة
            $conversationType = $request->first_party_type . '-to-' . $request->second_party_type;

            // إنشاء أو جلب المحادثة إذا كانت موجودة بالفعل
            $conversation = Conversation::firstOrCreate(
                [
                    'first_party_id' => $request->first_party_id,
                    'first_party_type' => $request->first_party_type,
                    'second_party_id' => $request->second_party_id,
                    'second_party_type' => $request->second_party_type,
                ],
                [
                    'first_party_id' => $request->first_party_id,
                    'first_party_type' => $request->first_party_type,
                    'second_party_id' => $request->second_party_id,
                    'second_party_type' => $request->second_party_type,
                    'type' => $conversationType, // حفظ نوع المحادثة
                ]
            );

            return response()->json([
                'data' => $conversation
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
            // جلب المحادثة بناءً على معرف المحادثة
            $conversation = Conversation::findOrFail($id);

            // جلب بيانات الطرف الأول بناءً على نوعه (مستخدم أو تاجر)
            $firstParty = null;
            if ($conversation->first_party_type === 'user') {
                $firstParty = User::find($conversation->first_party_id);
            } elseif ($conversation->first_party_type === 'vendor') {
                $firstParty = Vendor::find($conversation->first_party_id);
            }

            // جلب بيانات الطرف الثاني بناءً على نوعه (مستخدم أو تاجر)
            $secondParty = null;
            if ($conversation->second_party_type === 'user') {
                $secondParty = User::find($conversation->second_party_id);
            } elseif ($conversation->second_party_type === 'vendor') {
                $secondParty = Vendor::find($conversation->second_party_id);
            }

            return response()->json([
                'conversation' => $conversation,
                'first_party' => $firstParty,
                'second_party' => $secondParty
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }



    public function markMessagesAsReadForConversationsWithUnread()
    {
        try {
            // الحصول على جميع المحادثات التي تحتوي على رسائل غير مقروءة
            $conversationsWithUnread = Conversation::where('hasUnreadMessages', true)->get();

            foreach ($conversationsWithUnread as $conversation) {
                // تحديث جميع الرسائل غير المقروءة في كل محادثة إلى مقروءة
                Message::where('conversation_id', $conversation->id)
                    ->where('is_read', 0)
                    ->update(['is_read' => 1]);

                // تحديث العمود hasUnreadMessages في المحادثة إلى false
                $conversation->update(['hasUnreadMessages' => false]);
            }

            return response()->json([
                'message' => 'All unread messages in conversations have been marked as read.'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }



    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Conversation $conversation)
    {
        //
    }
}
