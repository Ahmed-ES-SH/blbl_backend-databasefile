<?php

namespace App\Http\Controllers;

use App\Models\ServicesTypes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class ServicesTypesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            // بناء الاستعلام مع ترتيب البيانات حسب تاريخ الإنشاء وتصفيتها حسب status = "published"
            $query = ServicesTypes::orderBy('created_at', 'desc');

            // تطبيق التصفية (pagination)
            $servicestypes = $query->paginate(18);

            return response()->json([
                'data' => $servicestypes->items(), // جلب العناصر الحالية فقط
                'current_page' => $servicestypes->currentPage(),
                'last_page' => $servicestypes->lastPage(),
                'total' => $servicestypes->total(),
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
                'title' => 'required|min:6|max:30|unique:services_types,title',
                'image' => 'required|image|file'
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $serviceType = new ServicesTypes();
            $serviceType->title = $request->title;
            // -------------------------
            // Add Image url    ----
            // -------------------------

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $PathVendorImage = 'images/vendors';
                $file->move(public_path($PathVendorImage), $filename);
                $serviceType->image = url('/') . '/'. 'public/' . $PathVendorImage . '/' . $filename;
            }

            $serviceType->save();

            return response()->json([
                'data' => $serviceType
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
            $servicetype = ServicesTypes::findOrFail($id);
            return response()->json([
                'data' => $servicetype
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
        }
    }

    public function getallservicesbyid($id)
    {
        try {
            $servicetype = ServicesTypes::findOrFail($id);
            $services = $servicetype->services;
            return response()->json([
                'data' => $services
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ]);
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
                'title' => 'sometimes|min:6|max:30|unique:services_types,title',
                'image' => 'sometimes|image|file'
            ]);

            // -----------------------------------
            // return all errors validation   ----
            // -----------------------------------

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ], 422);
            }

            $serviceType =  ServicesTypes::findOrFail($id);
            $serviceType->title = $request->title;
            // -------------------------
            // delete old image   ----
            // -------------------------
            if ($request->hasFile('image')) {
                $old_image = $serviceType->image;
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
                $serviceType->image = url('/') . '/'. 'public/' . $path . '/' . $filename;
            }

            $serviceType->save();

            return response()->json([
                'data' => $serviceType
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
            $serviceType =  ServicesTypes::findOrFail($id);
            // -------------------------
            // delete  image   ----
            // -------------------------
            $old_image = $serviceType->image;
            $oldname = basename(parse_url($old_image, PHP_URL_PATH));
            $path = 'images/vendors';
            $oldimagepath = public_path($path, $oldname);
            if (File::exists($oldimagepath)) {
                File::delete($oldimagepath);
            };

            $serviceType->delete();

            return response()->json([
                'message' => 'serviceType deleted successfuly'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
