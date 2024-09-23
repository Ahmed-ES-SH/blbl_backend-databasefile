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
        Schema::create('temp_payments', function (Blueprint $table) {
            $table->id();
            $table->string('temp_payment_id'); // معرف فريد
            $table->json('services_with_amount');
            $table->timestamp('expires_at'); // وقت انتهاء الصلاحية
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('temp_payments');
    }
};
