<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'category_id',
        'quantity',
        'purchase_date',
        'usage',
    ];

    protected $appends = [
        'category_name',
    ];

    public function getCategoryNameAttribute()
    {
        return $this->category->name ?? '';
    }

    public function category()
    {
        return $this->hasOne(Category::class, 'id', 'category_id');
    }
}
