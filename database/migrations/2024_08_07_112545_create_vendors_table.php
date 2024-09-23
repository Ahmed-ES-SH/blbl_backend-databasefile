<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('vendors', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->string('email')->unique();
            $table->string('password');
            $table->integer('balance')->default(0);
            $table->string('account_type')->default('vendor');
            $table->integer('number_of_orders')->default(0);
            $table->string('gender');
            $table->string('job');
            $table->string('is_available')->default("0");
            $table->string('phone_number');
            $table->string('location');
            $table->string('image')->nullable();
            $table->string('skills_experiences')->nullable();
            $table->longText('image_bank')->nullable();
            $table->string('About')->nullable();
            $table->decimal('rating')->nullable()->default(0);
            $table->decimal('start_price')->nullable();
            $table->decimal('end_price')->nullable();
            $table->decimal('coast')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vendors');
    }
};
