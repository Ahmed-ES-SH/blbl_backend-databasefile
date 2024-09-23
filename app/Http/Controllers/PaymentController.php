<?php

namespace App\Http\Controllers;

use App\Models\Bill;
use App\Models\service;
use App\Models\TempPayment;
use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use App\Services\MyFatoorahService;
use Illuminate\Support\Facades\Validator;

class PaymentController extends Controller
{
    protected $myFatoorahService;

    public function __construct(MyFatoorahService $myFatoorahService)
    {
        $this->myFatoorahService = $myFatoorahService;
    }

    public function createPayment(Request $request)
    {
        $amount = $request->input('amount');
        $servicesWithAmount = $request->servicesWithAmount;

        // توليد معرف فريد لتتبع الطلب
        $tempPaymentId = uniqid();
        
        
        
        
        
        
        
        // تخزين البيانات المؤقتة في قاعدة البيانات
        TempPayment::create([
            'temp_payment_id' => $tempPaymentId,
            'services_with_amount' => $servicesWithAmount,
            'expires_at' => now()->addMinutes(10), // مدة الصلاحية
        ]);

    $billId =  rand(100000, 999999);

        Bill::create([
            'unique_id' => $billId,
            'user_id' => $request->user_id,
            'bill_value' => $amount,
            'bill_status' => 0,
        ]);

        $customerDetails = [
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'NotificationOption' => 'LNK',
        ];

        $response = $this->myFatoorahService->createPayment($amount, 'USD', $customerDetails, $tempPaymentId, $billId);

        return response()->json($response);
    }


    public function getPaymentStatus(Request $request)
    {
        $paymentId = $request->paymentId;
        $response = $this->myFatoorahService->getPaymentStatus($paymentId);

        return response()->json($response);
    }


    private function updateVendorBalance($vendorId, $amount)
    {
        $vendor = Vendor::find($vendorId);

        if ($vendor) {
            $vendor->balance += $amount;
            $vendor->number_of_orders += 1;
            $vendor->save();
        }
    }

    public function handleCallback(Request $request)
    {
        $paymentId = $request->query('paymentId');
        $tempPaymentId = $request->query('tempPaymentId');
        $billId = $request->query('billId');
        if (!$tempPaymentId) {
            return response()->json(['message' => 'failedTempPaymentId']);
        }

        $response = $this->myFatoorahService->getPaymentStatus($paymentId);

        if ($response['IsSuccess'] && $response['Data']['InvoiceStatus'] === 'Paid') {
            $tempPayment = TempPayment::where('temp_payment_id', $tempPaymentId)
                ->where('expires_at', '>', now())
                ->first();

            if ($tempPayment) {
                $servicesWithAmount = $tempPayment->services_with_amount;

                // تحقق من صحة السلسلة
                if (!is_string($servicesWithAmount) || empty($servicesWithAmount)) {
                    return response()->json(['message' => 'invalidDataFormat']);
                }

                // محاولة تحويل السلسلة إلى مصفوفة
                $servicesWithAmountArray = json_decode($servicesWithAmount, true);

                // التحقق من نجاح التحويل
                if (json_last_error() !== JSON_ERROR_NONE || !is_array($servicesWithAmountArray)) {
                    return response()->json(['message' => $servicesWithAmountArray]);
                }

                foreach ($servicesWithAmountArray as $service) {
                    $vendorId = $service['id'];
                    $amount = $service['totalAmount'];

                    $this->updateVendorBalance($vendorId, $amount);
                }

                $bill = Bill::where('unique_id' , $billId)->first(); // جلب الفاتورة بناءً على معرفها
                if (!$bill) {
    return response()->json(['message' => 'Bill not found']);
}
                $bill->bill_status = '1' ;
                $bill->save();

                $tempPayment->delete();

                return redirect()->to('https://blbl-test-2.vercel.app/success?transactionId=' . $paymentId);
            } else {
                return response()->json(['message' => 'failedTempPayment']);
            }
        } else {
            return redirect()->to('https://blbl-test-2.vercel.app/error?errorMessage=' . urlencode('Payment failed or status unknown'));
        }
    }





    public function addFunds(Request $request)
    {
        $amount = $request->amount;
        $userId = $request->user_id;
        $customerDetails = [
            'name' => $request->name,
            'email' => $request->email,
        ];

        $response = $this->myFatoorahService->createPaymentfunds($amount, 'USD', $customerDetails, $userId);

        return response()->json($response);
    }

    public function addFundsCallback(Request $request)
    {
        try {
            $paymentId = $request->query('paymentId');
            $userId = $request->query('userId');
            $billId = uniqid();

            $response = $this->myFatoorahService->getPaymentStatus($paymentId);

            if ($response['IsSuccess'] && $response['Data']['InvoiceStatus'] === 'Paid') {
                $user = User::findOrFail($userId);
                $amount = $response['Data']['InvoiceValue'];

                Bill::create([
                    'id' => $billId,
                    'user_id' =>  $userId,
                    'bill_value' => $amount,
                    'bill_status' => 1,
                ]);

                $user->balance += $amount;
                $user->save();

                return redirect()->to('https://blbl-test-2.vercel.app/success?transactionId=' . $paymentId);
            } else {
                return redirect()->to('https://blbl-test-2.vercel.app/error?errorMessage=' . urlencode('Payment failed or status unknown'));
            }
        } catch (\Exception $e) {
            return redirect()->to('https://blbl-test-2.vercel.app/error?errorMessage=' . urlencode('An error occurred during payment processing'));
        }
    }


    public function paywithbalance(Request $request, $user_id)
    {
        try {
            // التحقق من صحة البيانات المرسلة
            $validation = Validator::make($request->all(), [
                'amount' => 'required|numeric',
                'services_with_amount' => 'required|string'
            ]);

            // إرجاع الأخطاء إن وجدت
            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            // الحصول على المستخدم
            $user = User::findOrFail($user_id);

            $balance = $user->balance;
            $code = mt_rand(100000000000000, 999999999999999);

            // التحقق من توفر الرصيد الكافي
            if ($balance >= $request->amount) {
                $servicesWithAmount = $request->services_with_amount;

                // محاولة تحويل السلسلة إلى مصفوفة
                $servicesWithAmountArray = json_decode($servicesWithAmount, true);

                // التحقق من نجاح التحويل
                if (json_last_error() !== JSON_ERROR_NONE || !is_array($servicesWithAmountArray)) {
                    return response()->json(['message' => 'invalidJsonFormat']);
                }

                // خصم المبلغ من رصيد المستخدم
                $user->balance -= $request->amount;
                $user->save();

                // تحديث أرصدة البائعين
                foreach ($servicesWithAmountArray as $service) {
                    if (isset($service['id']) && isset($service['totalAmount'])) {
                        $vendorId = $service['id'];
                        $amount = $service['totalAmount'];

                        // تحديث رصيد البائع
                        $this->updateVendorBalance($vendorId, $amount);
                    } else {
                        return response()->json(['message' => 'invalidServiceData']);
                    }
                }

                // إعادة التوجيه لصفحة النجاح مع معرف المعاملة
                return response()->json([
                    'data' => $code,
                    'message' => 'pay is done'
                ]);
            } else {
                // في حال عدم توفر الرصيد الكافي
                return response()->json(['message' => 'InsufficientBalance']);
            }
        } catch (\Exception $e) {
            // معالجة الأخطاء غير المتوقعة
            return response()->json(['message' => $e->getMessage()]);
        }
    }



    public function handleError(Request $request)
    {
        return view('payment.error');
    }
}
