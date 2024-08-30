<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;

class ItemController extends Controller
{
    public function index()
    {
        return response()->json(Item::with('category')->get());
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'category_id' => 'required|exists:categories,id',
            'quantity' => 'required|integer',
            'purchase_date' => 'required|date',
            'usage' => 'required|string',
        ]);

        $item = Item::create($request->all());

        return response()->json($item, 201);
    }

    public function show($id)
    {
        $item = Item::with('category')->findOrFail($id);
        return response()->json($item);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string',
            'category_id' => 'required|exists:categories,id',
            'quantity' => 'required|integer',
            'purchase_date' => 'required|date',
            'usage' => 'required|string',
        ]);

        $item = Item::findOrFail($id);
        $item->update($request->all());

        return response()->json($item);
    }

    public function destroy($id)
    {
        $item = Item::findOrFail($id);
        $item->delete();

        return response()->json(null, 204);
    }
}

