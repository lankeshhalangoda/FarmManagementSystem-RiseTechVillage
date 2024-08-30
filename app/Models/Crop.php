<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Crop extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'growth_stage',
        'planting_date',
        'harvest_date',
        'cycle_progress',
    ];

    protected $appends = [
        'growth_stage_note'
    ];

    public function getGrowthStageNoteAttribute()
    {
        return $this->growthEntries->note ?? '';
    }

    public function growthEntries()
    {
        return $this->hasOne(GrowthEntry::class);
    }

    public function recommendations()
    {
        return $this->hasMany(Recommendation::class);
    }
}
