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
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('description', 255);
            $table->decimal('coast', 8, 2);
            $table->string('image')->nullable();
            $table->decimal('rating')->nullable();
            $table->decimal('link_video')->nullable();
            $table->string('status')->default('pending');
            $table->decimal('start_price')->nullable();
            $table->decimal('end_price')->nullable();
            $table->json('extra_services')->nullable();
            $table->json('key_words')->nullable();
            $table->unsignedBigInteger('vendor_id');
            $table->unsignedBigInteger('servicetype_id');
            $table->foreign('vendor_id')->references('id')->on('vendors')->onDelete('cascade');
            $table->foreign('servicetype_id')->references('id')->on('services_types')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
