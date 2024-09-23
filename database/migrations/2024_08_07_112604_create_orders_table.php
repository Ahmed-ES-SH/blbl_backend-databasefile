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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('title', 100);
            $table->string('sender_type');
            $table->string('Service_descripe')->nullable()->default('');
            $table->string('image')->nullable();
            $table->decimal('coast', 10, 2)->nullable();
            $table->string('service_type')->nullable();
            $table->text('special_instructions')->nullable();
            $table->unsignedBigInteger('servicetype_id');
            $table->unsignedBigInteger('vendor_id')->nullable();
            $table->unsignedBigInteger('sender_id')->nullable();
            $table->foreign('servicetype_id')->references('id')->on('services_types')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
