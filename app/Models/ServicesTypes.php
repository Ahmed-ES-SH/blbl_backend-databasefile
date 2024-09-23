<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServicesTypes extends Model
{
    use HasFactory;


    protected $fillable = [
        'title',
        'image'
    ];

    public function services()
    {
        return $this->hasMany(service::class);
    }
    public function orders()
    {
        return $this->hasMany(order::class);
    }
}
