<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\SoilCondition;

class SoilConditionSeeder extends Seeder
{
    public function run()
    {
        SoilCondition::create([
            'location' => 'Field A',
            'temperature' => 22.5,
            'moisture' => 45.0,
            'ph_level' => 6.8,
        ]);

        SoilCondition::create([
            'location' => 'Field B',
            'temperature' => 18.2,
            'moisture' => 55.0,
            'ph_level' => 7.2,
        ]);
    }
}

