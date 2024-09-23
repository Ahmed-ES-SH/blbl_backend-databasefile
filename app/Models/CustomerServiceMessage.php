<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerServiceMessage extends Model
{
    use HasFactory;

    protected $fillable = ['customerserviceconversation_id',
                            'audio',
                            'image',
                            'is_read',
                            'sender_id',
                            'sender_type',
                            'message'];

    public function CustomerConversation()
    {
        return $this->belongsTo(Customerserviceconversation::class);
    }
}
