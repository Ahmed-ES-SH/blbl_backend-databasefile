<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bill extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'unique_id',
        'user_id',
        'bill_value',
        'status'
    ];

    public function user()
    {
        return  $this->belongsTo(User::class);
    }
}
