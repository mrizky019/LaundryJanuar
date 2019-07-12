<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('auth/register', 'AuthController@register');
Route::post('auth/login', 'AuthController@login');
Route::post('customer/store', 'PelangganController@store');
Route::put('customer/update/{id_pelanggan}', 'PelangganController@update');
Route::get('customer/search', 'PelangganController@search');
Route::get('customer/all', 'PelangganController@getPelanggan');
Route::get('admin/users', 'UserController@users');