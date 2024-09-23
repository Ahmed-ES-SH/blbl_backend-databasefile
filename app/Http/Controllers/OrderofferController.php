<?php

namespace App\Http\Controllers;

use App\Models\orderoffer;
use App\Models\User;
use App\Models\vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use function PHPUnit\Framework\isEmpty;

class OrderofferController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index($order_id)
{
    try {
        // جلب العروض مع الترتيب والصفحات
        $offers = orderoffer::where('order_id', $order_id)
            ->orderBy('created_at')
            ->paginate(15);

        if ($offers->isEmpty()) {
            return response()->json([
                'data' => []
            ]);
        }

        // جلب المعلومات الكاملة لكل عرض
        $offersWithSender = $offers->map(function ($offer) {
            $type = $offer->sender_type;
            $sender_id = $offer->sender_id;

            if ($type == 'user') {
                $offer->sender = User::where('id', $sender_id)->first();
            } else {
                $offer->sender = vendor::where('id', $sender_id)->first();
            }

            return $offer;
        });

        return response()->json([
            'data' => $offersWithSender, // جلب العناصر الحالية مع معلومات المرسل
            'current_page' => $offers->currentPage(),
            'last_page' => $offers->lastPage(),
            'total' => $offers->total(), // إضافة العدد الكلي للعناصر
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'data' => $e->getMessage()
        ], 500);
    }
}

    public function getofferscount($order_id)
    {
        try {
            $offers = orderoffer::where('order_id', $order_id)->count();

            return response()->json([
                'data' => $offers
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
            $validation = Validator::make($request->all(), [
                'offer' => 'required',
                'sender_id' => 'required',
                'sender_type' => 'required',
                'order_id' => 'required|exists:orders,id',
            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            $offer = new orderoffer();
            $offer->offer = $request->offer;
            $offer->sender_id = $request->sender_id;
            $offer->sender_type = $request->sender_type;
            $offer->order_id = $request->order_id;

            $offer->save();

            return response()->json([
                'data' => $offer
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'data' => $e->getMessage()
            ], 500);
        }
    }
}
