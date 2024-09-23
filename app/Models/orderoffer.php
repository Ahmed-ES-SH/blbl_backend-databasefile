<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orderoffer extends Model
{
    use HasFactory;


    protected $fillable = [
        'offer',
        'sender_id',
        'order_id',
        'sender_type'
    ];


    public function order()
    {
        return $this->belongsTo(order::class);
    }
    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
}
