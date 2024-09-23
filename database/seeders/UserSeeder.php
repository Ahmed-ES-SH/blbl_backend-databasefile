<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;


class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $urlimage = 'https://alrajhost.com';
        $path = 'images/users';
        $fullpath = public_path($path);
        $images = scandir($fullpath);
        $imagesarray = array_filter($images, function ($image) {
            return in_array(pathinfo($image, PATHINFO_EXTENSION), ['jpg', 'jpeg', 'png', 'gif', 'webp']);
        });

        for ($i = 0; $i < 50; $i++) {
            $imageuser = $imagesarray[array_rand($imagesarray)];
            $imageurl = $urlimage . '/' . 'public/' . $path . '/' . $imageuser;
            DB::table('users')->insert([
                'name' => $i + 1 . ' إسم المتسخدم ',
                'email' => Str::random(10) . "@fakeemail.com",
                'image' => $imageurl,
                'location' => '{"address":"43, سندوب وكفر المناصرة, المنصورة, الدقهلية, 35796, مصر","latitude":31.024665651815244,"longitude":31.396865844726566}',
                'phone_number' => '9909234345' . $i + 1,
                'created_at' => now(),
                'password' => Hash::make('password')
            ]);
        }
    }
}
