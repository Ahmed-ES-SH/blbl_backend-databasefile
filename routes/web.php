<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\MyFatoorahController;

Route::controller(MyFatoorahController::class)->group(function () {
    Route::post('/payment/create', 'index');
    Route::get('/payment/callback', 'callback')->name('myfatoorah.callback');
});

// Routes for handling the success and error pages
Route::get('/payment-success', function () {
    return view('payment.success');
});

Route::get('/payment-failed', function () {
    return view('payment.failed');
});

Route::get('/payment-expired', function () {
    return view('payment.expired');
});

Route::get('/payment-error', function () {
    return view('payment.error');
});
