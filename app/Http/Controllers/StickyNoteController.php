<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\StickyNote;

class StickyNoteController extends Controller
{
    public function index()
    {
        return response()->json(StickyNote::all());
    }

    public function store(Request $request)
    {
        $note = StickyNote::create($request->all());
        return response()->json($note, 201);
    }

    public function update(Request $request, $id)
    {
        $note = StickyNote::findOrFail($id);
        $note->update($request->all());
        return response()->json($note);
    }

    public function destroy($id)
    {
        StickyNote::destroy($id);
        return response()->json(null, 204);
    }
}
