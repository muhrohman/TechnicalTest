<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');

        $items = Item::with(['transactions' => function ($query) use ($startDate, $endDate) {
            if ($startDate && $endDate) {
                $query->whereBetween('transaction_date', [$startDate, $endDate]);
            } elseif ($startDate) {
                $query->where('transaction_date', '>=', $startDate);
            } elseif ($endDate) {
                $query->where('transaction_date', '<=', $endDate);
            }
        }])->get();

        $report = $items->map(function ($item) {
            $in = $item->transactions->where('type', 'in')->sum('quantity');
            $out = $item->transactions->where('type', 'out')->sum('quantity');
            return [
                'id' => $item->id,
                'item_code' => $item->item_code,
                'name' => $item->name,
                'unit' => $item->unit,
                'initial_stock' => $item->initial_stock,
                'total_in' => $in,
                'total_out' => $out,
                'final_stock' => $item->initial_stock + $in - $out,
            ];
        });

        return response()->json($report);
    }
}
