<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class vendor extends Authenticatable
{
    use HasApiTokens,  Notifiable;

    protected $table = 'vendors'; // تأكد من أن اسم الجدول صحيح
    protected $primaryKey = 'id';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'image',
        'gender',
        'phone_number',
        'balance',
        'is_available',
        'location',
        'job',
        'skills_experiences',
        'image_bank',
        'About',
        'rating',
        'start_price',
        'end_price',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];



    public function services()
    {
        return $this->hasMany(service::class);
    }
    public function orderoffer()
    {
        return $this->hasMany(orderoffer::class);
    }
    public function order()
    {
        return $this->hasMany(order::class);
    }
    public function ordermoney()
    {
        return $this->hasMany(ordermoney::class);
    }
    public function Vendorservices()
    {
        return $this->hasMany(Vendorservices::class);
    }
}
