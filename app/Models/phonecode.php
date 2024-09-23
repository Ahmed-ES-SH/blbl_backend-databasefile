<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class phonecode extends Model
{
    use HasFactory;

    protected $fillable = [
        'phone_number',
        'code',
        'created_at',
        'updated_at',
    ];
}
