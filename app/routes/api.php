<?php

use Illuminate\Support\Facades\Route;

Route::post('/registration', 'App\Http\Controllers\UserController@register');
Route::get('/profile/{id}', 'App\Http\Controllers\UserController@profile');
