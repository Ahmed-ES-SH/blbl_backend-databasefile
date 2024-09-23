<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Infobip\Configuration;
use Infobip\ApiException;
use Infobip\Api\SmsApi;
use Infobip\Model\SmsAdvancedTextualRequest;
use Infobip\Model\SmsDestination;
use Infobip\Model\SmsTextualMessage;
use Illuminate\Support\Str;



class AuthController extends Controller
{


    private function sendSms($phone, $message)
    {
        $configuration = new Configuration(
            host: env('INFOBIB_HOST'),
            apiKey: env('INFOBIB_API_KEY')
        );

        $sendSmsApi = new SmsApi(config: $configuration);

        $smsMessage = new SmsTextualMessage(
            destinations: [
                new SmsDestination(to: $phone)
            ],
            from: 'Blbl-Website',
            text: $message
        );

        $request = new SmsAdvancedTextualRequest(messages: [$smsMessage]);

        try {
            $smsResponse = $sendSmsApi->sendSmsMessage($request);
            return $smsResponse;
        } catch (ApiException $apiException) {
            throw new \Exception("Failed to send SMS: " . $apiException->getMessage());
        }
    }




    public function register(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'name' => 'required|min:4|max:30|unique:users|unique:vendors,name',
                'email' => 'required|email|unique:users|unique:vendors,email',
                'password' => 'required|min:6',
                'image' => 'file|image|nullable',
                'phone_number' => 'required|max:20|min:11',
                'location' => 'required|string',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 500);
            }

            // توليد كود التحقق عشوائياً من 4 أرقام
            $verificationCode = rand(1000, 9999);

            // حفظ الكود في قاعدة البيانات
            DB::table('phonecodes')->insert([
                'phone_number' => $request->phone_number,
                'code' => $verificationCode,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // إرسال كود التحقق
            $this->sendSms($request->phone_number, "Hi , from Blbl Website Your verification code is: $verificationCode");

            return response()->json([
                'message' => 'Verification code sent successfully.',
                'phone_number' => $request->phone_number,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    public function registerfromdashbord (Request $request) {
          try {
            $validation = Validator::make($request->all(), [
                'name' => 'required|min:4|max:30|unique:users|unique:vendors,name',
                'email' => 'required|email|unique:users|unique:vendors,email',
                'password' => 'required|min:6',
                'image' => 'file|image|nullable',
                'phone_number' => 'required|max:20|min:11',
                'location' => 'required|string',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 500);
            }
            
            // إنشاء المستخدم بعد التحقق
        $user = new User();
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password  = Hash::make($request->password);
        $user->phone_number = $request->phone_number;
        $user->location = $request->location;
        $user->role = $request->role;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $filename = date('Ymd-His') . '.' . $image->getClientOriginalExtension();
            $path = 'images/users';
            $image->move(public_path($path), $filename);
            $user->image = url('/')   . '/' .'public/' . $path . '/' . $filename;
        }

        $user->save();
        
           return response()->json([
            'data' => $user,
        ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }
    
    
    public function registerasguest(Request $request)
    {
       

        $user = User::create([
            'name' => Str::random(2) . '-' . 'guest',
            'email' => Str::random(12)  . '@fakeemail.com',
            'role' => 'guest',
            'phone_number' => Str::random(12) . 'fake',
            'location' => Str::random(2) . 'fakelocation',
            'password' => Hash::make('password'),
            'is_guest' => true, // تعيين القيمة الافتراضية
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'data' => $user,
            'type' => 'guest',
            'token' => $token,
            'token_type' => 'Bearer',
        ], 201);
    }
    
    
    public function quickaccesswithphone(Request $request)
{
    try {
        $validation = Validator::make($request->all(), [
            'phone_number' => 'required|max:20|min:9',
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 500);
        }

        // تحقق من وجود كود حديث لنفس الرقم
        $existingCode = DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->orderBy('created_at', 'desc')
            ->first();

        if ($existingCode && now()->diffInMinutes($existingCode->created_at) < 5) {
            return response()->json([
                'message' => 'You can request a new verification code after 5 minutes.',
            ], 429); // Too many requests
        }

        // توليد كود التحقق عشوائياً من 4 أرقام
        $verificationCode = rand(1000, 9999);

        // حفظ الكود في قاعدة البيانات
        DB::table('phonecodes')->insert([
            'phone_number' => $request->phone_number,
            'code' => $verificationCode,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        // إرسال كود التحقق
        $this->sendSms($request->phone_number, "Hi, from Blbl Website. Your verification code is: $verificationCode");

        return response()->json([
            'message' => 'Verification code sent successfully.',
            'phone_number' => $request->phone_number,
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}


public function verifyCodeAndCreateUser(Request $request)
{
    try {
        // التحقق من صحة المدخلات
        $validation = Validator::make($request->all(), [
            'phone_number' => 'required|max:20|min:9',
            'code' => 'required|digits:4', // يجب أن يكون الكود مكون من 4 أرقام
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 500);
        }

        // التحقق من وجود الكود ورقم الهاتف في قاعدة البيانات
        $verificationData = DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->where('code', $request->code)
            ->first();

        if (!$verificationData) {
            return response()->json([
                'message' => 'Invalid phone number or verification code.',
            ], 400); // 400 Bad Request
        }

        // توليد بيانات عشوائية للمستخدم الجديد
        $randomName = 'User_' . Str::random(6);
        $randomEmail = strtolower(Str::random(8)) . '@example.com';
        $randomPassword = Str::random(10); // كلمة مرور عشوائية

        // إنشاء المستخدم الجديد
        $user = new User();
        $user->name = $randomName;
        $user->email = $randomEmail;
        $user->phone_number = $request->phone_number;
        $user->location = 'location_' . Str::random(6);
        $user->role = 'guest';
        $user->password = Hash::make($randomPassword);// تشفير كلمة المرور
        $user->is_guest = 1;
        $user->save();

        // حذف سجل التحقق بعد النجاح
        DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->where('code', $request->code)
            ->delete();
            
            $token = $user->createToken('auth_token')->plainTextToken;

        // إرجاع معلومات المستخدم الجديد وكلمة المرور العشوائية
        return response()->json([
            'message' => 'User created successfully.',
            'user' => $user,
            'token' => $token
        ], 201); // 201 Created

    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}




    public function verifyuserPhone(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'phone_number' => 'required',
            'code' => 'required',
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        // التحقق من الكود
        $codeEntry = DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->where('code', $request->code)
            ->first();

        if (!$codeEntry) {
            return response()->json(['message' => 'Invalid verification code.'], 422);
        }

        // إنشاء المستخدم بعد التحقق
        $user = new User();
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password  = Hash::make($request->password);
        $user->phone_number = $request->phone_number;
        $user->location = $request->location;

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $filename = date('Ymd-His') . '.' . $image->getClientOriginalExtension();
            $path = 'images/users';
            $image->move(public_path($path), $filename);
            $user->image = url('/')  .  '/' .'public/'  . $path . '/' . $filename;
        }

        $user->save();
        $token = $user->createToken('auth_token')->plainTextToken;

        DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->delete();

        return response()->json([
            'data' => $user,
            'token' => $token,
            'token_type' => 'Bearer',
        ], 201);
    }

    public function resendPhoneCode(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'phone_number' => 'required',
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        // التحقق من وجود رقم الهاتف في قاعدة البيانات
        $phoneCodeEntry = DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->first();

        if (!$phoneCodeEntry) {
            return response()->json(['message' => 'Phone number not found.'], 404);
        }

        // توليد كود جديد
        $newCode = rand(1000, 9999); // توليد كود مكون من 4 أرقام

        // تحديث الكود في قاعدة البيانات
        DB::table('phonecodes')
            ->where('phone_number', $request->phone_number)
            ->update(['code' => $newCode]);

        $this->sendSms($request->phone_number, "Hi , from Blbl Website Your verification code is: $newCode");


        return response()->json(['message' => 'Verification code resent successfully.'], 200);
    }


    public function login(Request $request)
    {
        try {
            $validation = Validator::make($request->all(), [
                'email' => 'required|email',
                'password' => 'required',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            };

            $user = User::where('email', $request->email)->firstOrFail();

            if (!$user || !Hash::check($request->password, $user->password)) {
                return response()->json([
                    'error' => 'Unauthorized'
                ], 401);
            };

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'data' => $user,
                'access_token' => $token,
                'token_type' => 'Bearer',
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ]);
        }
    }

    public function loginWithPhone(Request $request)
    {
        $validation = Validator::make($request->all(), [
            'phone_number' => 'required',
            'password' => 'required'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        // التحقق من المستخدمين
        $user = User::where('phone_number', $request->phone_number)->first();
        if ($user && Hash::check($request->password, $user->password)) {
            $user->is_available = 1;
            $user->save();
            $token = $user->createToken('auth_token')->plainTextToken;
            return response()->json([
                'data' => $user,
                'message' => 'Logged in as user successfully',
                'token' => $token,
                'guard' => 'api' // تحديد الحارس المستخدم
            ], 200);
        }

        // التحقق من البائعين
        $vendor = Vendor::where('phone_number', $request->phone_number)->first();
        if ($vendor && Hash::check($request->password, $vendor->password)) {
            $vendor->is_available = 1;
            $vendor->save();
            $token = $vendor->createToken('auth_token')->plainTextToken;
            return response()->json([
                'data' => $vendor,
                'message' => 'Logged in as vendor successfully',
                'token' => $token,
                'guard' => 'vendor' // تحديد الحارس المستخدم
            ], 200);
        }

        return response()->json([
            'message' => 'Invalid phone number or password'
        ], 401);
    }

   public function logout(Request $request)
    {
        try {
            // التحقق من صحة الطلب
            $validation = Validator::make($request->all(), [
                'user_id' => 'required|integer',
                'user_type' => 'required|in:user,vendor'
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $user_type = $request->user_type;
            $user_id = $request->user_id;

            if ($user_type == 'user') {
                $user = User::find($user_id); // استخدام find بدلاً من where
                if ($user) {
                    $user->is_available = 0;
                    $is_guest = $user->is_guest ;
                    $user->save();
                    // حذف الرموز الخاصة بالمستخدم
                    $user->tokens()->delete();
                    // تسجيل الخروج
                    Auth::logout();
                    
                    if ($is_guest) {
                        $user->delete();
                    }
                    return response()->json([
                        'message' => 'Logged out successfully'
                    ], 200);
                } else {
                    return response()->json([
                        'message' => 'User not found'
                    ], 404);
                }
            } elseif ($user_type == 'vendor') {
                $vendor = Vendor::find($user_id); // استخدام find بدلاً من where
                if ($vendor) {
                    $vendor->is_available = 0;
                    $vendor->save();
                    // حذف الرموز الخاصة بالبائع
                    $vendor->tokens()->delete();
                    // تسجيل الخروج
                    Auth::logout();
                    return response()->json([
                        'message' => 'Logged out successfully'
                    ], 200);
                } else {
                    return response()->json([
                        'message' => 'Vendor not found'
                    ], 404);
                }
            } else {
                return response()->json([
                    'message' => 'Invalid user type'
                ], 400);
            }
        } catch (\Exception $e) {
            Log::error('Logout error: ' . $e->getMessage());
            return response()->json([
                'error' => 'An error occurred while logging out'
            ], 500);
        }
    }
}
