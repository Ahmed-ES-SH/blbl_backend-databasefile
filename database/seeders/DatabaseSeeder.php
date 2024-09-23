<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            VendorSeeder::class,
            ServiceTypeSeeder::class,
            ServiceSeeder::class,
            OrderSeeder::class,
            SliderSeeder::class,
            // أضف باقي الـ seeders هنا
        ]);
    }
}
