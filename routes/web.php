<?php

use Illuminate\Support\Facades\Route;
use Scalar\Controllers\ScalarController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/privacy', function () {
    return view('privacy');
});

Route::get('/terms', function () {
    return view('terms');
});

Route::get('/user-data-deletion', function () {
    return view('user-data-deletion');
});

Route::get('/docs', ScalarController::class);
