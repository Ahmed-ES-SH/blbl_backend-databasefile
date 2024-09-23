<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customerservice extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'message',
        'message_status',
    ];

    // Polymorphic relationship
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
