<?php

namespace App\Http\Controllers;

use App\Models\GrowthEntry;
use App\Models\Crop;
use Illuminate\Http\Request;

class GrowthEntryController extends Controller
{
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string',
            'stage' => 'required|string',
            'note' => 'required|string',
        ]);

        $data = [
            'name' => $validatedData['name'],
            'growth_stage' => $validatedData['stage'],
            'planting_date' => now(),
            'harvest_date' => now()->addDays(90),
            'cycle_progress' => 0,
        ];

        if($data['growth_stage'] === 'Seedling') {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 20;
        }elseif($data['growth_stage'] === 'Vegetative') {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 40;
        }elseif($data['growth_stage'] === 'Flowering') {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 60;
        }elseif($data['growth_stage'] === 'Fruiting') {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 80;
        }elseif($data['growth_stage'] === 'Ripening') {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 100;
        } else {
            $data['planting_date'] = now();
            $data['harvest_date'] = now()->addDays(90);
            $data['cycle_progress'] = 0;
        }

        $crop = Crop::create($data);

        $growthEntry = $crop->growthEntries()->create([
            'stage' => $validatedData['stage'],
            'note' => $validatedData['note'],
        ]);

        return response()->json($growthEntry, 201);
    }
}
