<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreItemRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'name' => 'required|string',
            'unit' => 'required|in:pcs,box,kg,liter,meter,roll',
            'initial_stock' => 'required|integer',
        ];
    }
}
