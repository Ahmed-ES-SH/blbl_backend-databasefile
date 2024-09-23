<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PendingPayment extends Model
{
    use HasFactory;
    protected $fillable = [
        'payment_id',
        'services_with_amount',
        'status',
    ];
}
