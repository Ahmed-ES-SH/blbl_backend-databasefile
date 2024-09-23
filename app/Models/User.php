<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;


    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'is_guest',
        'is_available',
        'balance',
        'image',
        'phone_number',
        'latitude',
        'location',
        'longitude',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function addresses()
    {
        return $this->hasMany(adress::class);
    }
    public function orders()
    {
        return $this->hasMany(order::class);
    }
    public function notifactions()
    {
        return $this->hasMany(Notifaction::class);
    }
    public function messages()
    {
        return $this->hasMany(Message::class);
    }
    public function user()
    {
        return  $this->hasMany(Bill::class);
    }

    public function customerServices()
    {
        return $this->hasMany(CustomerService::class);
    }
}
