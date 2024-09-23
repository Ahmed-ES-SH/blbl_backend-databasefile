<?php

namespace App\Http\Controllers;


use Illuminate\Support\Facades\DB;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Infobip\Configuration;
use Infobip\ApiException;
use Infobip\Api\SmsApi;
use Infobip\Model\SmsAdvancedTextualRequest;
use Infobip\Model\SmsDestination;
use Infobip\Model\SmsTextualMessage;


class vendorController extends Controller
{



   private function sendSms($phone, $message)
    {
        $configuration = new Configuration(
            host: "3858dn.api.infobip.com",
            apiKey: "3cacb164b73cdb0fc96116396856fe2e-325331c3-f3a7-4ae1-b1fc-cf9f51fe4e2f"
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



    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // ----------------------------
            // get all vendors data   -----
            // ----------------------------
            $vendors = vendor::orderBy('created_at', 'desc')->paginate(18);
            foreach ($vendors as $vendor) {
                if (is_string($vendor->skills_experiences)) {
                    $vendor->skills_experiences = json_decode($vendor->skills_experiences, true);
                };
            };
            return response()->json([
                'data' => $vendors->items(), // جلب العناصر الحالية فقط
                'current_page' => $vendors->currentPage(),
                'last_page' => $vendors->lastPage(),
                'total' => $vendors->total()
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }


    public function sortbyorders()
    {
        try {
            // ----------------------------
            // get all vendors data   -----
            // ----------------------------
            $vendors = vendor::orderBy('number_of_orders', 'desc')->paginate(18);
            foreach ($vendors as $vendor) {
                if (is_string($vendor->skills_experiences)) {
                    $vendor->skills_experiences = json_decode($vendor->skills_experiences, true);
                };
            };
            return response()->json([
                'data' => $vendors->items(), // جلب العناصر الحالية فقط
                'current_page' => $vendors->currentPage(),
                'last_page' => $vendors->lastPage(),
                'total' => $vendors->total()
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }



    public function getvendorsCount()
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $vendorCount = vendor::count();
            return response()->json([
                'data' => $vendorCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function gettopten()
    {
        try {
            // ----------------------------
            // get all vendors data   -----
            // ----------------------------
            $vendors = vendor::orderBy('rating', 'desc')->take(10)->get(); // جلب أفضل 10 تجار

            foreach ($vendors as $vendor) {
                if (is_string($vendor->skills_experiences)) {
                    $vendor->skills_experiences = json_decode($vendor->skills_experiences, true);
                }
            }

            return response()->json([
                'data' => $vendors, // جلب العناصر الحالية فقط
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500); // إضافة كود الحالة 500
        }
    }


    public function searchforvendorbyname(Request $request)
    {

        try {
            $validation = Validator::make($request->all(), [
                'name' => 'required'
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            $vendors = vendor::where('name', 'like', '%' . $request->name . '%')
                ->select('id', 'name')
                ->get();

            if ($vendors->isEmpty()) {
                return response()->json([
                    'message' => 'No vendors found with the given name.'
                ], 404); // Use 404 Not Found for no matching records
            }



            return response()->json([
                'data' => $vendors
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage()
            ]);
        };
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'name' => 'required|min:4|max:30|unique:vendors',
                'email' => 'required|email|unique:vendors',
                'password' => 'required|min:6',
                'image' => 'nullable|file|image',
                'gender' => 'required',
                'location' => 'required',
                'phone_number' => 'required|nullable',
                'job' => 'required',
                'skills_experiences' => 'nullable',
                'image_bank' => 'nullable|file|image',
                'About' => 'nullable|max:255',
                'rating' => 'nullable',
                'start_price' => 'nullable|numeric',
                'end_price' => 'nullable|numeric',
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

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
                'message' => $e->getMessage()
            ], 500);
        }
    }
    
    
     public function storefromdashbord(Request $request)
    {
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'name' => 'required|min:4|max:30|unique:vendors',
                'email' => 'required|email|unique:vendors',
                'password' => 'required|min:6',
                'image' => 'nullable|file|image',
                'gender' => 'required',
                'location' => 'required',
                'phone_number' => 'required|nullable',
                'job' => 'required',
                'skills_experiences' => 'nullable',
                'image_bank' => 'nullable|file|image',
                'About' => 'nullable|max:255',
                'rating' => 'nullable',
                'start_price' => 'nullable|numeric',
                'end_price' => 'nullable|numeric',
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 500);
            }
        $vendor = new vendor();
        $vendor->name = $request->name;
        $vendor->email = $request->email;
        $vendor->password = Hash::make($request->password);
        $vendor->gender = $request->gender;
        $vendor->job = $request->job;
        $vendor->phone_number = $request->phone_number;
        $vendor->location = $request->location;
        $vendor->skills_experiences = $request->skills_experiences;
        $vendor->About = $request->About;
        $vendor->rating = $request->rating;
        $vendor->start_price = $request->start_price;
        $vendor->end_price = $request->end_price;

        // -------------------------
        // Add Image url    ----
        // -------------------------

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $filename = date('Ymd-His') . '.' . $file->getClientOriginalExtension();
            $PathvendorImage = 'images/vendors';
            $file->move(public_path($PathvendorImage), $filename);
            $vendor->image = url('/') . '/'. 'public/' . $PathvendorImage . '/' . $filename;
        }

        // -------------------------
        // Add Image bank   ----
        // -------------------------
        if ($request->hasFile('image_bank')) {
            $file = $request->file('image_bank');
            $filename = date('Ymd-His') . '.' . $file->getClientOriginalExtension();
            $PathBankImage = 'images/bank';
            $file->move(public_path($PathBankImage), $filename);
            $vendor->image_bank = url('/') . '/'. 'public/' . $PathBankImage . '/' . $filename;
        }


        // ----------------------------------
        // should be save data in end    ----
        // ----------------------------------
        $vendor->save();


        return response()->json([
            'Message' => 'Add vendor Success',
        ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function verifiyvendorphone(Request $request)
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

        $vendor = new vendor();
        $vendor->name = $request->name;
        $vendor->email = $request->email;
        $vendor->password = Hash::make($request->password);
        $vendor->gender = $request->gender;
        $vendor->job = $request->job;
        $vendor->phone_number = $request->phone_number;
        $vendor->location = $request->location;
        $vendor->skills_experiences = $request->skills_experiences;
        $vendor->About = $request->About;
        $vendor->rating = $request->rating;
        $vendor->start_price = $request->start_price;
        $vendor->end_price = $request->end_price;

        // -------------------------
        // Add Image url    ----
        // -------------------------

        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $filename = date('Ymd-His') . '.' . $file->getClientOriginalExtension();
            $PathvendorImage = 'images/vendors';
            $file->move(public_path($PathvendorImage), $filename);
            $vendor->image = url('/') . '/'. 'public/' . $PathvendorImage . '/' . $filename;
        }

        // -------------------------
        // Add Image bank   ----
        // -------------------------
        if ($request->hasFile('image_bank')) {
            $file = $request->file('image_bank');
            $filename = date('Ymd-His') . '.' . $file->getClientOriginalExtension();
            $PathBankImage = 'images/bank';
            $file->move(public_path($PathBankImage), $filename);
            $vendor->image_bank = url('/') . '/'. 'public/' . $PathBankImage . '/' . $filename;
        }


        // ----------------------------------
        // should be save data in end    ----
        // ----------------------------------
        $vendor->save();

        $token = $vendor->createToken('auth_token')->plainTextToken;

        return response()->json([
            'Message' => 'Add vendor Success',
            'token' => $token,
            'token_type' => 'Bearer',
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        // ----------------------------------
        // get the vendor by id     ----
        // ----------------------------------
        try {
            $vendor = vendor::findOrFail($id);

            return response()->json([
                'data' => $vendor
            ], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'vendor not found'
            ], 404);
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
        // -------------------------
        // Validation data   ----
        // -------------------------

        try {
            $validation = Validator::make($request->all(), [
                'name' => 'sometimes|min:6|max:30',
                'email' => 'email|unique:vendors,email',
                'image' => 'nullable|file|image|mimes:jpeg,png,jpg,gif',
                'skills_experiences' => 'sometimes',
                'image_bank' => 'file|image|mimes:jpeg,png,jpg,gif',
                'location' => 'sometimes',
                'phone_number' => 'sometimes',
                'About' => 'nullable|max:255',
                'rating' => 'nullable',
                'start_price' => 'numeric',
                'end_price' => 'numeric',
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            // ----------------------------------
            // get the vendor by id     ----
            // ----------------------------------
            $vendor = vendor::findOrFail($id);

            // ---------------------------------------
            // check the filds need to update     ----
            // ---------------------------------------

            $filds = ['name', 'email', 'About', 'rating', 'location', 'phone_number',  'skills_experiences', 'start_price', 'end_price'];
            foreach ($filds as $fild) {
                if ($request->has($fild)) {
                    $vendor->$fild = $request->$fild;
                };
            };


            // -------------------------
            // delete old image   ----
            // -------------------------
            if ($request->hasFile('image')) {
                $old_image = $vendor->image;
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/vendors';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
                // -------------------------
                // update new image   ----
                // -------------------------
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $file->move(public_path($path), $filename);
                $vendor->image = url('/') . '/'. 'public/' . $path . '/' . $filename;
            }
            // ---------------------------
            // delete old imagebank   ----
            // ---------------------------
            if ($request->hasFile('image_bank')) {
                $old_image_bank = $vendor->image_bank;
                $path = 'images/vendors';
                $oldname = basename(parse_url($old_image_bank, PHP_URL_PATH));
                $PathBankImage = 'images/bank';
                $oldimagebankpath = public_path($PathBankImage, $oldname);
                if (File::exists($oldimagebankpath)) {
                    File::delete($oldimagebankpath);
                };
                // ----------------------------
                // update new imagebank   -----
                // ----------------------------

                $file = $request->file('image_bank');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $file->move(public_path($path), $filename);
                 $vendor->image_bank = url('/') . '/'. 'public/' . $PathBankImage . '/' . $filename;
            }

            $vendor->save();

            return response()->json([
                'data' => $vendor,
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
            $vendor = vendor::findOrFail($id);
            // -------------------------
            // delete old image   ----
            // -------------------------
            $old_image = $vendor->image;
            if ($old_image) {
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/vendors';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
            }

            // ---------------------------
            // delete old imagebank   ----
            // ---------------------------

            $old_image_bank = $vendor->image_bank;
            if ($old_image_bank) {
                $oldname = basename(parse_url($old_image_bank, PHP_URL_PATH));
                $PathBankImage = 'images/bank';
                $oldimagebankpath = public_path($PathBankImage, $oldname);
                if (File::exists($oldimagebankpath)) {
                    File::delete($oldimagebankpath);
                };
            }

            $vendor->delete();

            return response()->json([
                'message' => 'vendor deleted successfully'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }
}
