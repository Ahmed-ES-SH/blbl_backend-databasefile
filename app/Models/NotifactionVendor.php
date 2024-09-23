<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NotifactionVendor extends Model
{
    use HasFactory;

    protected $fillable = ['vendor_id', 'message', 'read'];

    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
}
