<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ItemController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\AuthController;

Route::get('/', function () {
    return view('welcome');
});

Route::prefix('api')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    
    Route::middleware('auth')->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::get('user', [AuthController::class, 'user']);
        
        Route::resource('items', ItemController::class);
        Route::resource('transactions', TransactionController::class);
        Route::get('reports', [ReportController::class, 'index']);
    });
});

// Catch-all for Vue Router
Route::get('/{any}', function () {
    return view('welcome');
})->where('any', '.*');
