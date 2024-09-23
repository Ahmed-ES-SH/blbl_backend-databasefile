<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ServiceTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
         $urlimage = 'https://alrajhost.com';
        $path = 'images/servicestypes';
        $fullpath = public_path($path);
        $files = scandir($fullpath);
        $images = array_filter($files, function ($file) {
            return in_array(pathinfo($file, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });

        for ($i = 0; $i < 50; $i++) {
            $image = $images[array_rand($images)];
            $imageurl = $urlimage . '/' . 'public/' . $path . '/' . $image;
            DB::table('services_types')->insert([
                'title' => $i . 'عنوان القسم ',
                'image' => $imageurl
            ]);
        }
    }
}
