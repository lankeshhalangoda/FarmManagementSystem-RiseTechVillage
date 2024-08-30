<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GrowthEntry extends Model
{
    use HasFactory;

    protected $fillable = [
        'crop_id',
        'stage',
        'note',
    ];

    public function crop()
    {
        return $this->belongsTo(Crop::class);
    }
}
