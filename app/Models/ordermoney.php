<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ordermoney extends Model
{
    use HasFactory;

    protected $fillable = [
        'paypalaccount',
        'amount',
        'order_status',
        'vendor_id',
    ];

    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
}
