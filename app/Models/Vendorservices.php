<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vendorservices extends Model
{
    use HasFactory;
    protected $fillable = [
        'vendor_id',
        'message',
        'message_status',
    ];

    // Polymorphic relationship
    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
}
