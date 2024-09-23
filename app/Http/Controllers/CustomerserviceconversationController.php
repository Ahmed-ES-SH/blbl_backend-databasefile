<?php

namespace App\Http\Controllers;

use App\Models\Customerserviceconversation;
use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CustomerserviceconversationController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // جلب جميع المحادثات بترتيب زمني تنازلي
            $conversations = Customerserviceconversation::orderBy('created_at', 'desc')->get();

            // قائمة لاحتواء البيانات بعد تجهيزها
            $conversationData = [];

            // التعامل مع كل محادثة
            foreach ($conversations as $conversation) {
                // جلب وكيل خدمة العملاء
                $agent = User::findOrFail($conversation->agent_id);

                // التحقق من نوع المحادثة (مستخدم أو تاجر)
                if ($conversation->conversation_type == 'vendor') {
                    // إذا كانت المحادثة مع تاجر
                    $secondParty = Vendor::findOrFail($conversation->secend_party_id);
                } else {
                    // إذا كانت المحادثة مع مستخدم
                    $secondParty = User::findOrFail($conversation->secend_party_id);
                }

                // تخزين البيانات لكل محادثة
                $conversationData[] = [
                    'conversation' => $conversation,
                    'agent' => $agent,
                    'second_party' => $secondParty
                ];
            }

            // إرجاع النتيجة كـ JSON
            return response()->json([
                'data' => $conversationData
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }




    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'agent_id' => 'required',
                'secend_party_id' => 'required',
                'conversation_type' => 'required',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            $conversation = Customerserviceconversation::firstOrCreate(
                [
                    'agent_id' => $request->agent_id,
                    'secend_party_id' => $request->secend_party_id,
                    'conversation_type' => $request->conversation_type,
                ],
                [
                    'agent_id' => $request->agent_id,
                    'secend_party_id' => $request->secend_party_id,
                    'conversation_type' => $request->conversation_type,
                ]
            );

            return response()->json([
                'data' => $conversation
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ]);
        }
    }

    /**
     * Display the specified resource.
     */
public function show_secend_party($secend_party_id, $current_user_type)
{
    try {
        // جلب جميع المحادثات المرتبطة بالـ secend_party_id
        $conversations = Customerserviceconversation::where('secend_party_id', $secend_party_id)->get();

        // تحقق من وجود المحادثات
        if ($conversations->isEmpty()) {
            return response()->json([
                'message' => 'No conversations found for this second party'
            ], 404);
        }

        $data = [];

        // معالجة كل محادثة على حدة
        foreach ($conversations as $conversation) {
            $agent_id = $conversation->agent_id;
            $conversation_type = $conversation->conversation_type;

            // تحقق مما إذا كان نوع المحادثة يتوافق مع نوع المستخدم الحالي
            if ($current_user_type !== $conversation_type) {
                continue; // تخطي هذه المحادثة إذا لم تتطابق الأنواع
            }

            $agent = User::findOrFail($agent_id);

            // تحديد الطرف الثاني بناءً على نوع المحادثة
            if ($conversation_type == 'vendor') {
                $secend_party = Vendor::findOrFail($conversation->secend_party_id);
            } else {
                $secend_party = User::findOrFail($conversation->secend_party_id);
            }

            // إضافة تفاصيل المحادثة إلى البيانات
            $data[] = [
                'conversation' => $conversation,
                'agent' => $agent,
                'second_party' => $secend_party
            ];
        }

        return response()->json([
            'data' => $data
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
            $conversation = Customerserviceconversation::findOrFail($id);
            $agent_id = $conversation->agent_id;
            $secend_party = $conversation->secend_party_id;
            $conversation_type = $conversation->conversation_type;
            $agent = User::findOrFail($agent_id);
            if ($conversation_type == 'vendor') {
                $secend_party = vendor::findOrFail($secend_party);
            } else {
                $secend_party = User::findOrFail($secend_party);
            }

            $data = [
                'conversation' => $conversation,
                'agent' => $agent,
                'second_party' => $secend_party
            ];
            return response()->json([
                'data' => $data
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
    public function destroy(Customerserviceconversation $customerserviceconversation)
    {
        //
    }
}
