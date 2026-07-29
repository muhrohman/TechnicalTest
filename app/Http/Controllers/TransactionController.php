<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Http\Requests\StoreTransactionRequest;

class TransactionController extends Controller
{
    public function index()
    {
        return response()->json(Transaction::with('item')->get());
    }

    public function store(StoreTransactionRequest $request)
    {
        $transaction = Transaction::create($request->validated());
        return response()->json($transaction->load('item'), 201);
    }
}
