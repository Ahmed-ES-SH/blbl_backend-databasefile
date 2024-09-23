<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;

class service extends Model
{
    use HasFactory, Notifiable;
    protected $fillable = [
        'title',
        'image',
        'rating',
        'start_price',
        'coast',
        'status',
        'end_price',
        'extra_services',
        'key_words',
    ];

    protected $casts = [
        'key_words' => 'array',
        'extra_services' => 'array',
    ];

    public function vendor()
    {
        return $this->belongsTo(vendor::class);
    }
    public function servicetype()
    {
        return $this->belongsTo(ServicesTypes::class);
    }
}
