<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recommendation extends Model
{
    use HasFactory;

    protected $fillable = [
        'crop_id',
        'message',
    ];

    public function crop()
    {
        return $this->belongsTo(Crop::class);
    }
}
