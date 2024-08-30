<?php

use App\Http\Controllers\DashboardController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CropController;
use App\Http\Controllers\GrowthEntryController;
use App\Http\Controllers\ItemController;
use App\Http\Controllers\RecommendationController;
use App\Http\Controllers\SoilConditionController;
use App\Http\Controllers\StickyNoteController;

Route::middleware(['auth:sanctum', 'verified'])->group(function () {
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');
    Route::get('/test', [DashboardController::class, 'test'])->name('test');
    Route::get('/crop', [DashboardController::class, 'crop'])->name('crop');
    Route::get('/inventory', [DashboardController::class, 'inventory'])->name('inventory');
    Route::get('/soil', [DashboardController::class, 'soil'])->name('soil');

    Route::prefix('categories')->group(function () {
        Route::get('/', [CategoryController::class, 'index']);
        Route::post('/', [CategoryController::class, 'store']);
        Route::get('/{id}', [CategoryController::class, 'show']);
        Route::put('/{id}', [CategoryController::class, 'update']);
        Route::delete('/{id}', [CategoryController::class, 'destroy']);
    });

    Route::prefix('items')->group(function () {
        Route::get('/', [ItemController::class, 'index']);
        Route::post('/', [ItemController::class, 'store']);
        Route::get('/{id}', [ItemController::class, 'show']);
        Route::put('/{id}', [ItemController::class, 'update']);
        Route::delete('/{id}', [ItemController::class, 'destroy']);
    });

    Route::get('/soil-conditions', [SoilConditionController::class, 'index'])->name('soil_conditions.index');
    Route::post('/soil-conditions', [SoilConditionController::class, 'store'])->name('soil_conditions.store');
    Route::get('/soil-conditions/{soilCondition}', [SoilConditionController::class, 'show'])->name('soil_conditions.show');
    Route::put('/soil-conditions/{soilCondition}', [SoilConditionController::class, 'update'])->name('soil_conditions.update');
    Route::delete('/soil-conditions/{soilCondition}', [SoilConditionController::class, 'destroy'])->name('soil_conditions.destroy');

    Route::resource('crops', CropController::class);
    Route::post('crops/{crop}/growth-entries', [GrowthEntryController::class, 'store']);
    Route::get('crops/{crop}/next-stage', [CropController::class, 'nextStage'])->name('crops.next-stage');
    Route::resource('recommendations', RecommendationController::class)->only(['index', 'store']);

    Route::resource('notes', StickyNoteController::class);

});


require __DIR__ . '/auth.php';
