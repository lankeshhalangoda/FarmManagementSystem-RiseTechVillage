<?php

namespace App\Http\Controllers;

use App\Models\SoilCondition;
use Illuminate\Http\Request;

class SoilConditionController extends Controller
{
    public function index()
    {
        $soilConditions = SoilCondition::all();
        return response()->json($soilConditions);
    }

    public function store(Request $request)
    {
        $request->validate([
            'location' => 'required|string|max:255',
            'temperature' => 'required|numeric',
            'moisture' => 'required|numeric',
            'ph_level' => 'required|numeric',
        ]);

        $soilCondition = SoilCondition::create($request->all());
        return response()->json($soilCondition, 201);
    }

    public function show(SoilCondition $soilCondition)
    {
        return response()->json($soilCondition);
    }

    public function update(Request $request, SoilCondition $soilCondition)
    {
        $request->validate([
            'location' => 'required|string|max:255',
            'temperature' => 'required|numeric',
            'moisture' => 'required|numeric',
            'ph_level' => 'required|numeric',
        ]);

        $soilCondition->update($request->all());
        return response()->json($soilCondition);
    }

    public function destroy(SoilCondition $soilCondition)
    {
        $soilCondition->delete();
        return response()->json(null, 204);
    }
}

