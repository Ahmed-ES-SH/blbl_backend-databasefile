<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class VendorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
         $urlimage = 'https://alrajhost.com';
        $genders = ['female', 'male'];
        $path = 'images/vendors';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });

        $categoriesides = DB::table('services_types')->pluck('id')->toArray();

        for ($i = 0; $i < 50; $i++) {
            $imageuser = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/' . 'public/' . $path . '/' . $imageuser;
            DB::table('vendors')->insert([
                'name' => $i + 1 . ' إٍسم التاجر  ',
                'email' => Str::random(8) . '@fake.com',
                'password' => Hash::make('asdasd'),
                'image' => $imageurl,
                'gender' => $genders[array_rand($genders)],
                'job' => 'fake-job',
                'phone_number' => '0109234345' . $i + 1,
                'location' => '{"address":"مصطفى الاجرودى, الغربية, 31953, مصر","latitude":30.9696706,"longitude":31.168083}',
                'rating' => '3.2',
                'start_price' => '200',
                'end_price' => '500'
            ]);
        }
    }
}
