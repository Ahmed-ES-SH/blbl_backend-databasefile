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
        Schema::create('vendorservices', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('vendor_id'); // معرف المرسل
            $table->text('message'); // نص الرسالة
            $table->enum('message_status', ['pending', 'in_progress', 'resolved'])->default('pending'); // حالة الرسالة
            $table->foreign('vendor_id')->references('id')->on('vendors')->onDelete('cascade');
            $table->timestamps(); // تاريخ الإضافة والتحديث
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vendorservices');
    }
};
