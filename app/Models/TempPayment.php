<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TempPayment extends Model
{
    use HasFactory;

    protected $fillable = [
        'services_with_amount',
        'temp_payment_id',
        'expires_at',
    ];
}
