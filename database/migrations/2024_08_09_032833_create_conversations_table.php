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
       Schema::create('conversations', function (Blueprint $table) {
    $table->id();
    $table->unsignedBigInteger('first_party_id');
    $table->string('first_party_type'); // user or vendor
    $table->unsignedBigInteger('second_party_id');
    $table->boolean('hasUnreadMessages');
    $table->string('second_party_type'); // user or vendor
    $table->string('type'); // type of conversation
    $table->timestamps();
});
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('conversations');
    }
};
