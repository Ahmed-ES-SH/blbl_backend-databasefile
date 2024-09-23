<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;


class SliderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
         $urlimage = 'https://alrajhost.com';
        $path = 'images/sliders';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });

        $stars = ['2', '3', '4', '5'];

        for ($i = 0; $i < 5; $i++) {
            $imageuser = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/' . 'public/' . $path . '/'  . $imageuser;
            DB::table('sliders')->insert([
                'title' => 'العرض الرئيسى ' . $i  + 1,
                'image' => $imageurl,
                'description' => ' وصف العرض الرئيسى ' . $i  + 1,
                'extra-content' => Str::random(10) . '@extra-content',
                'rating' => $stars[array_rand($stars)],
                'stars' => $stars[array_rand($stars)],
                'created_at' => now(),

            ]);
        }
    }
}
