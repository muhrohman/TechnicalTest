<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    use HasFactory;

    protected $fillable = ['item_code', 'name', 'unit', 'initial_stock'];
    protected $appends = ['final_stock'];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($item) {
            $latestItem = self::orderBy('id', 'desc')->first();
            if ($latestItem && preg_match('/BRG-(\d+)/', $latestItem->item_code, $matches)) {
                $newNumber = (int)$matches[1] + 1;
            } else {
                $newNumber = 1;
            }
            $item->item_code = 'BRG-' . str_pad($newNumber, 3, '0', STR_PAD_LEFT);
        });
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class);
    }

    public function getFinalStockAttribute()
    {
        $in = $this->transactions()->where('type', 'in')->sum('quantity');
        $out = $this->transactions()->where('type', 'out')->sum('quantity');
        return $this->initial_stock + $in - $out;
    }
}
