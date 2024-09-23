<?php

namespace App\Http\Controllers;

use App\Models\order;
use App\Models\User;
use App\Models\vendor;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */



   public function index()
{
    try {
        // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء
        $orders = order::orderBy('created_at', 'desc')->paginate(18);

        // إضافة بيانات المرسل بناءً على نوعه
        $ordersWithSender = $orders->map(function ($order) {
            $type = $order->sender_type;
            $sender_id = $order->sender_id;

            if ($type == 'user') {
                $order->sender = User::find($sender_id);
            } else {
                $order->sender = vendor::find($sender_id);
            }

            return $order;
        });

        return response()->json([
            'data' => $ordersWithSender, // جلب العناصر الحالية فقط
            'current_page' => $orders->currentPage(),
            'last_page' => $orders->lastPage(),
            'total' => $orders->total(),
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}

    public function getOrdersCount()
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $OrdersCount = Order::count();
            return response()->json([
                'data' => $OrdersCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


    public function searchfororderbyname(Request $request)
{
    try {
        // التحقق من صحة البيانات
        $validation = Validator::make($request->all(), [
            'titlesearch' => 'required|string'
        ]);

        if ($validation->fails()) {
            return response()->json([
                'errors' => $validation->errors()
            ], 422);
        }

        // بناء الاستعلام مع تطبيق البحث إذا تم تقديمه
        $orders = Order::where('title', 'like', '%' . $request->titlesearch . '%')
            ->orderBy('created_at', 'desc')
            ->paginate(18);

        // إضافة بيانات المرسل بناءً على نوعه
        $ordersWithSender = $orders->map(function ($order) {
            $type = $order->sender_type;
            $sender_id = $order->sender_id;

            if ($type == 'user') {
                $order->sender = User::find($sender_id);
            } else {
                $order->sender = vendor::find($sender_id);
            }

            return $order;
        });

        return response()->json([
            'data' => $ordersWithSender, // جلب العناصر الحالية فقط
            'current_page' => $orders->currentPage(),
            'last_page' => $orders->lastPage(),
            'total' => $orders->total(), // إضافة العدد الكلي للعناصر
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}





   public function get5lastorders()
{
    try {
        // جلب أحدث 5 طلبات
        $orders = order::orderBy('created_at', 'desc')
            ->take(5)
            ->get();

        // إضافة بيانات المرسل بناءً على نوعه
        $ordersWithSender = $orders->map(function ($order) {
            $type = $order->sender_type;
            $sender_id = $order->sender_id;

            if ($type == 'user') {
                $order->sender = User::find($sender_id);
            } else {
                $order->sender = vendor::find($sender_id);
            }

            return $order;
        });

        return response()->json([
            'data' => $ordersWithSender
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
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'title' => 'required|string',
                'image' => 'nullable',
                'Service_descripe' => 'nullable|min:15',
                'Order_time' => 'nullable',
                'coast' => 'nullable|numeric',
                'special_instructions' => 'nullable',
                'sender_id' => 'required',
                'sender_type' => 'required',
                'servicetype_id' => 'required|exists:services_types,id',
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $order = new order();
            $order->title = $request->title;
            $order->Service_descripe = $request->Service_descripe;
            $order->coast = $request->coast;
            $order->service_type = $request->service_type;
            $order->special_instructions = $request->special_instructions;
            $order->sender_id = $request->sender_id;
            $order->sender_type = $request->sender_type;
            $order->servicetype_id = $request->servicetype_id;

            // -------------------------
            // Add Image url    ----
            // -------------------------

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $PathorderImage = 'images/orders';
                $file->move(public_path($PathorderImage), $filename);
                $order->image = url('/') . '/'. 'public/' . $PathorderImage . '/' . $filename;
            }

            $order->save();
            return response()->json([
                'data' => $order
            ]);
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
        // جلب الطلب بناءً على الـ ID
        $order = Order::findOrFail($id);

        // إضافة بيانات المرسل بناءً على نوعه
        $type = $order->sender_type;
        $sender_id = $order->sender_id;

        if ($type == 'user') {
            $order->sender = User::find($sender_id);
        } else {
            $order->sender = vendor::find($sender_id);
        }

        return response()->json([
            'data' => $order
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => $e->getMessage()
        ], 500);
    }
}



   
    public function getordersCountByUserId($user_id , $sender_type)
    {
        try {
            // جلب عدد العناوين بناءً على نوع الحساب
            $addressCount = order::where('sender_id', $user_id)
                ->where('sender_type' , $sender_type)
                ->count();

            return response()->json([
                'data' => $addressCount
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }


 public function getOrdersByUserId($user_id, $sender_type)
{
    try {
        // تحقق من صحة نوع المرسل
        if (!in_array($sender_type, ['user', 'vendor'])) {
            return response()->json([
                'message' => 'Invalid sender type.'
            ], 400);
        }

        // بناء الاستعلام مع تصفية حسب نوع المرسل وID المرسل
        $query = order::where('sender_id', $user_id)
            ->where('sender_type', $sender_type)
            ->orderBy('created_at', 'desc'); // يمكنك إضافة ترتيب إذا لزم الأمر

        // تطبيق التصفية (pagination)
        $orderspagenate = $query->paginate(10);

        return response()->json([
            'data' => $orderspagenate->items(), // جلب العناصر الحالية فقط
            'current_page' => $orderspagenate->currentPage(),
            'last_page' => $orderspagenate->lastPage(),
            'total' => $orderspagenate->total(),
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
        try {
            // -------------------------
            // Validation data   ----
            // -------------------------
            $validation = Validator::make($request->all(), [
                'title' => 'sometimes|string',
                'image' => 'sometimes|file|image',
                'Service_descripe' => 'sometimes|min:15|max:255',
                'Order_time' => 'sometimes',
                'coast' => 'sometimes|numeric',
                'service_type' => 'sometimes',
                'special_instructions' => 'nullable',
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $filds = [
                'title',
                'Service_descripe',
                'Order_time',
                'cost',
                'service_type',
                'special_instructions'
            ];

            $order =  order::findOrFail($id);
            foreach ($filds as $fild) {
                if ($request->has($fild)) {
                    $order->fild = $request->$fild;
                };
            };
            // -------------------------
            // Handle image upload   ----
            // -------------------------
            if ($request->hasFile('image')) {
                // -------------------------
                // delete old image    ----
                // -------------------------
                if ($order->image) {
                    $old_image = $order->image;
                    $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                    $path = 'images/orders';
                    $oldimagepath = public_path($path, $oldname);
                    if (File::exists($oldimagepath)) {
                        File::delete($oldimagepath);
                    };
                };
                // -------------------------
                // update new image   ----
                // -------------------------
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $file->move(public_path($path), $filename);
                $order->image = url('/') . '/'. 'public/' . $path . '/' . $filename;
            }


            $order->save();
            return response()->json([
                'data' => $order
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {
            $order = order::findOrFail($id);

            // -------------------------
            // delete  image   ----
            // -------------------------
            if ($order->image) {
                $old_image = $order->image;
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/orders';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
            };
            $order->delete();

            return response()->json([
                'message' => 'Order deleted Successfuly'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }
}
