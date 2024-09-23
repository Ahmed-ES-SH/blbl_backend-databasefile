<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customerserviceconversation extends Model
{
    use HasFactory;

    protected $fillable = [
        'agent_id',
        'secend_party_id',
        'conversation_type'
    ];

    public function messages()
    {
        return $this->hasMany(CustomerServiceMessage::class);
    }
}
