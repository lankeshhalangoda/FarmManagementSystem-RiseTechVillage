<?php

namespace App\Http\Controllers;

use App\Models\Recommendation;
use Illuminate\Http\Request;

class RecommendationController extends Controller
{
    public function index()
    {
        $recommendations = Recommendation::with('crop')->get();
        return response()->json($recommendations);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'crop_id' => 'required|exists:crops,id',
            'message' => 'required|string',
        ]);

        $recommendation = Recommendation::create($validatedData);
        return response()->json($recommendation, 201);
    }
}
