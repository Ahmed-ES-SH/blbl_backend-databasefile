<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class order extends Model
{
    use HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'Service_Requester',
        'image',
        'Service_descripe',
        'Order_time',
        'cost',
        'service_type',
        'service_type_id',
        'vendor_id',
        'special_instructions',
        'user_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
    public function servicetype()
    {
        return $this->belongsTo(ServicesTypes::class);
    }

    public function order()
    {
        return $this->hasMany(orderoffer::class);
    }
}
