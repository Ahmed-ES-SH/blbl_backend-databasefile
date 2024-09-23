<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $services_typesids = DB::table('services_types')->pluck('id')->toArray();
        $vendorsids = DB::table('vendors')->pluck('id')->toArray();
        $usersids = DB::table('users')->pluck('id')->toArray();
         $urlimage = 'https://alrajhost.com';
        $path = 'images/orders';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });


        for ($i = 0; $i < 50; $i++) {
            $imageuser = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/'. 'public/' . $path . '/' . $imageuser;
            DB::table('orders')->insert([
                'title' => 'عنوان الطلب - '  . $i + 1,
                'Service_descripe' => 'وصف الطلب - '  . $i + 1,
                'user_id' => $usersids[array_rand($usersids)],
                'vendor_id' => $vendorsids[array_rand($vendorsids)],
                'servicetype_id' => $services_typesids[array_rand($services_typesids)],
                'image' => $imageurl,
                'coast' => '300'
            ]);
        }
    }
}
