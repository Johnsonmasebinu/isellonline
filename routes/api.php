<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WhatsAppController;

Route::get('/status', function () {
    return response()->json([
        'maintenance' => env('MAINTENANCE_MODE', false)
    ]);
});

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::match(['get', 'post'], 'whatsapp/webhook', [WhatsAppController::class, 'webhook']);