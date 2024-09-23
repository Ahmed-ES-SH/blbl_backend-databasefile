<?php

namespace App\Http\Controllers;

use App\Models\ServiceSlider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;

class ServiceSliderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $sliders = ServiceSlider::all();
            return response()->json([
                'data' => $sliders
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'messsage' => $e->getMessage()
            ]);
        }
    }



    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {

            $validation  = Validator::make($request->all(), [
                'image' => 'required|file|image',
                'title' => 'required|min:6|max:30',

            ]);

            if ($validation->fails()) {
                return response()->json([
                    'errors' => $validation->errors()
                ]);
            }

            $slider = new ServiceSlider();


            $slider->title = $request->title;

            // -------------------------
            // Add Image url    ----
            // -------------------------

            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = date('Ymd-His') . '_' . $file->getClientOriginalExtension();
                $PathVendorImage = 'images/ServiceSliders';
                $file->move(public_path($PathVendorImage), $filename);
                $slider->image = url('/') . '/'. 'public/' . $PathVendorImage . '/' . $filename;
            }

            $slider->save();


            return response()->json([
                'data' => $slider
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'messsage' => $e->getMessage()
            ]);
        }
    }






    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try {

            $slider = ServiceSlider::findOrFail($id);
            // -------------------------
            // delete  image   ---------
            // -------------------------
            $old_image = $slider->image;
            if ($old_image) {
                $oldname = basename(parse_url($old_image, PHP_URL_PATH));
                $path = 'images/ServiceSliders';
                $oldimagepath = public_path($path, $oldname);
                if (File::exists($oldimagepath)) {
                    File::delete($oldimagepath);
                };
            }

            $slider->delete();

            return response()->json([
                'message' => 'Slider Deleted Successfuly'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'messsage' => $e->getMessage()
            ]);
        }
    }
}
