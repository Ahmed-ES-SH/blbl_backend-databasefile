<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Infobip\Configuration;
use Infobip\ApiException;
use Infobip\Api\SmsApi;
use Infobip\Model\SmsAdvancedTextualRequest;
use Infobip\Model\SmsDestination;
use Infobip\Model\SmsTextualMessage;


class SMSController extends Controller
{

    public function sendSms(Request $request)
    {
        $configuration = new Configuration(
            host: '3858dn.api.infobip.com',
            apiKey: '3cacb164b73cdb0fc96116396856fe2e-325331c3-f3a7-4ae1-b1fc-cf9f51fe4e2f'
        );

        $validation = Validator::make($request->all(), [
            'phone' => 'required',
            'message' => 'nullable'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ]);
        }

        $phone = $request->phone;

        // توليد كود عشوائي من 4 أرقام
        $code = mt_rand(1000, 9999);

        // إعداد الرسالة النصية مع الكود
        $messageText = "Hallo, from Blbl Website Your Verify Code is: $code it will be unusable in 60 min";

        $sendSmsApi = new SmsApi(config: $configuration);

        $message = new SmsTextualMessage(
            destinations: [
                new SmsDestination(to: $phone)
            ],
            from: 'Blbl-Website',
            text: $messageText
        );

        $request = new SmsAdvancedTextualRequest(messages: [$message]);

        try {
            $smsResponse = $sendSmsApi->sendSmsMessage($request);

            // حفظ الكود في جدول codes عند نجاح الإرسال
            DB::table('phonecodes')->insert([
                'phone' => $phone,
                'code' => $code,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            return response()->json(['message' => 'تم إرسال الرسالة بنجاح', 'response' => $smsResponse]);
        } catch (ApiException $apiException) {
            return response()->json(['message' => 'فشل في إرسال الرسالة', 'error' => $apiException->getMessage()]);
        }
    }
}
