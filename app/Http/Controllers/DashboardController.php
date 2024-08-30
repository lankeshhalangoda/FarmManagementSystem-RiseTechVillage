<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Auth\AuthController;
use App\Models\Crop;
use App\Models\Item;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Inertia\Inertia;
use modules\Facades\ProductFacade\ProductFacade;
use modules\Facades\SupplierFacade\SupplierFacade;

class DashboardController extends AuthController
{
    public function index()
    {
        $crops = Crop::where('growth_stage', 'Seedling')->get();

        $cropCount = [];
        for ($month = 1; $month <= 12; $month++) {
            $cropCount[$month] = 0;
        }

        foreach ($crops as $crop) {
            $month = Carbon::parse($crop->planting_date)->month;
            $cropCount[$month]++;
        }

        $items = Item::all();

        $itemCount = [];

        for ($month = 1; $month <= 12; $month++) {
            $itemCount[$month] = 0;
        }

        foreach ($items as $item) {
            $month = Carbon::parse($item->created_at)->month;
            $itemCount[$month]++;
        }

        $data = [
            'cropCount' => $cropCount,
            'itemCount' => $itemCount,
        ];


        return Inertia::render('Dashboard/index')->with($data);
    }

    public function inventory()
    {
        $currentMonth = Carbon::now()->month;
        $currentYear = Carbon::now()->year;

        $itemsCount = Item::selectRaw('DATE(purchase_date) as date, COUNT(*) as count')
            ->whereYear('purchase_date', $currentYear)
            ->whereMonth('purchase_date', $currentMonth)
            ->groupBy('date')
            ->get();

        $currentMonthDates = [];
        for ($day = 1; $day <= Carbon::now()->daysInMonth; $day++) {
            $date = Carbon::create($currentYear, $currentMonth, $day)->toDateString();
            $currentMonthDates[$date] = 0;
        }

        foreach ($itemsCount as $item) {
            $currentMonthDates[$item->date] = $item->count;
        }

        return Inertia::render('Inventory/index')->with('currentMonthDates', $currentMonthDates);
    }

    public function crop()
    {
        return Inertia::render('Crop/index');
    }

    public function soil()
    {
        return Inertia::render('Soil/index');
    }
}
