<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreTransactionRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'item_id' => 'required|exists:items,id',
            'type' => 'required|in:in,out',
            'transaction_date' => 'required|date',
            'quantity' => 'required|integer|min:1',
            'description' => 'nullable|string',
        ];
    }
}
