<?php

namespace App\Http\Controllers;

use App\Models\Crop;
use Illuminate\Http\Request;

class CropController extends Controller
{
    public function index()
    {
        $crops = Crop::with('recommendations')->get();
        return response()->json($crops);
    }


    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string',
            'growth_stage' => 'required|string',
            'planting_date' => 'required|date',
            'harvest_date' => 'required|date',
            'cycle_progress' => 'required|integer|min:0|max:100',
        ]);

        $crop = Crop::create($validatedData);
        return response()->json($crop, 201);
    }

    public function show(Crop $crop)
    {
        return response()->json($crop->load('recommendations', 'growthEntries'));
    }

    public function update(Request $request, Crop $crop)
    {
        $validatedData = $request->validate([
            'name' => 'string',
            'growth_stage' => 'string',
            'planting_date' => 'date',
            'harvest_date' => 'date',
            'cycle_progress' => 'integer|min:0|max:100',
        ]);

        $crop->update($validatedData);
        return response()->json($crop);
    }

    public function destroy(Crop $crop)
    {
        $crop->delete();
        return response()->json(null, 204);
    }

    public function nextStage($id)
    {
        $crop = Crop::find($id);

        if ($crop->growth_stage === 'Seedling') {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 20;
            $crop->growth_stage = 'Vegetative';
        } elseif ($crop->growth_stage === 'Vegetative') {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 40;
            $crop->growth_stage = 'Flowering';
        } elseif ($crop->growth_stage === 'Flowering') {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 60;
            $crop->growth_stage = 'Fruiting';
        } elseif ($crop->growth_stage === 'Fruiting') {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 80;
            $crop->growth_stage = 'Ripening';
        } elseif ($crop->growth_stage === 'Ripening') {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 100;
            $crop->growth_stage = 'Harvested';
        } else {
            $crop->planting_date = now();
            $crop->harvest_date = now()->addDays(90);
            $crop->cycle_progress = 0;
            $crop->growth_stage = 'Seedling';
        }

        $crop->save();
    }
}
