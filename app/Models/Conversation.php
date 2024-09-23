<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Conversation extends Model
{
    use HasFactory;


    protected $fillable = ['first_party_id', 'first_party_type', 'second_party_id' ,'second_party_type' ,'type' ,  'hasUnreadMessages'];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function vendor()
    {
        return $this->belongsTo(vendor::class, 'vendor_id');
    }
    public function agent()
    {
        return $this->belongsTo(User::class, 'agent_id');
    }

    public function messages()
    {
        return $this->hasMany(Message::class);
    }
}
