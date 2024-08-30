<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    protected $allowedCategories = ['Seeds', 'Fertilizers', 'Pesticides', 'Other'];

    public function index()
    {
        return response()->json(Category::all());
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => ['required', 'string', 'in:' . implode(',', $this->allowedCategories)],
        ]);

        $category = Category::create($request->all());

        return response()->json($category, 201);
    }

    public function show($id)
    {
        $category = Category::findOrFail($id);
        return response()->json($category);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => ['required', 'string', 'in:' . implode(',', $this->allowedCategories)],
        ]);

        $category = Category::findOrFail($id);
        $category->update($request->all());

        return response()->json($category);
    }

    public function destroy($id)
    {
        $category = Category::findOrFail($id);
        if (in_array($category->name, $this->allowedCategories)) {
            $category->delete();
            return response()->json(null, 204);
        } else {
            return response()->json(['error' => 'Cannot delete this category.'], 403);
        }
    }
}
