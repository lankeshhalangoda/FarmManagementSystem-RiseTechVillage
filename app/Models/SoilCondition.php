<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SoilCondition extends Model
{
    use HasFactory;

    protected $fillable = [
        'location',
        'temperature',
        'moisture',
        'ph_level',
    ];
}

