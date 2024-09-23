<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class servicesliderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $urlimage = 'https://alrajhost.com';
        $path = 'images/servicestypes';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });


        for ($i = 0; $i < 10; $i++) {
            $imageuser = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/' . 'public/' . $path . '/' . $imageuser;
            DB::table('service_sliders')->insert([
                'title' => 'عنوان الخدمة ' . $i  + 1,
                'image' => $imageurl,
                'created_at' => now(),

            ]);
        }
    }
}
