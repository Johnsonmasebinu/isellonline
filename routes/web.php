<?php

use Illuminate\Support\Facades\Route;
use Scalar\Controllers\ScalarController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/docs', ScalarController::class);
