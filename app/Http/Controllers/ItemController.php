<?php

namespace App\Http\Controllers;

use App\Models\Item;
use App\Http\Requests\StoreItemRequest;
use App\Http\Requests\UpdateItemRequest;

class ItemController extends Controller
{
    public function index()
    {
        return response()->json(Item::all());
    }

    public function store(StoreItemRequest $request)
    {
        $item = Item::create($request->validated());
        return response()->json($item, 201);
    }

    public function show(Item $item)
    {
        return response()->json($item);
    }

    public function update(UpdateItemRequest $request, Item $item)
    {
        $item->update($request->validated());
        return response()->json($item);
    }

    public function destroy(Item $item)
    {
        $item->delete();
        return response()->json(null, 204);
    }
}
