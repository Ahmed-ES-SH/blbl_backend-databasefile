<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;


class ServiceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $extra_service1 = new \stdClass();
        $extra_service1->title_extra_service = 'خدمة إضافية 1';
        $extra_service1->coast_extra_service = '23';

        $extra_service2 = new \stdClass();
        $extra_service2->title_extra_service = 'خدمة إضافية 2';
        $extra_service2->coast_extra_service = '21';
        $extra_services = [$extra_service1, $extra_service2];
        $key_words = ['test', 'test', 'test'];
        $rating_number = [4, 3, 2, 4, 5, 3, 2];
        $vendorsids = DB::table('vendors')->pluck('id')->toArray();
        $services_typesids = DB::table('services_types')->pluck('id')->toArray();
        $urlimage = 'https://alrajhost.com';
        $path = 'images/services';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });

        for ($i = 0; $i < 50; $i++) {
            $image = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/'. 'public/' . $path . '/' . $image;
            DB::table('services')->insert([
                'title' => $i . 'عنوان الخدمة ',
                'description' => $i . 'وصف الخدمة ',
                'image' => $imageurl,
                'extra_services' => json_encode($extra_services),
                'key_words' => json_encode($key_words),
                'start_price' => '299',
                'coast' => '400',
                'status' => 'published',
                'end_price' => '799',
                'rating' => $rating_number[array_rand($rating_number)],
                'created_at' => now(),
                'vendor_id' => $vendorsids[array_rand($vendorsids)],
                'servicetype_id' => $services_typesids[array_rand($services_typesids)],
            ]);
        }
    }
}
