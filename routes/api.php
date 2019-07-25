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

//Route Users
Route::get('admin', 'UserController@show');
Route::post('auth/register', 'AuthController@register');
Route::post('auth/login', 'AuthController@login');

//Route Customer
Route::post('customer/store', 'PelangganController@store');
Route::put('customer/update', 'PelangganController@update');
Route::delete('customer/delete/{id_pelanggan}', 'PelangganController@destroy');
Route::get('customer/search', 'PelangganController@search');
Route::get('customer', 'PelangganController@show');

//Route Pegawai
Route::post('pegawai/store', 'PegawaiController@store');
Route::get('pegawai/searchByBranch', 'PegawaiController@searchByBranch');
Route::put('pegawai/update', 'PegawaiController@update');
Route::delete('pegawai/delete/{id_pegawai}', 'PegawaiController@destroy');
Route::get('pegawai/search', 'PegawaiController@search');
Route::get('pegawai', 'PegawaiController@show');

//Route Menu
Route::get('menu/show', 'MenuController@show');

//Route Transaksi
Route::post('transaksi/store', 'TransaksiController@store');
Route::get('transaksi/showUnfinished', 'TransaksiController@showUnfinished');
Route::put('transaksi/paid', 'TransaksiController@paid');
Route::put('transaksi/take', 'TransaksiController@take');
Route::get('transaksi/getTransaction', 'TransaksiController@getTransaction');
Route::get('transaksi/showFinishedTransaction', 'TransaksiController@showFinishedTransaction');
//Route AktivitasLaundry

Route::get('aktivitaslaundry/show', 'AktivitasLaundryController@show');
Route::post('aktivitaslaundry/melakukanAktivitasLaundry', 'AktivitasLaundryController@melakukanAktivitasLaundry');
Route::post('aktivitaslaundry/menyelesaikanAktivitasLaundry', 'AktivitasLaundryController@menyelesaikanAktivitasLaundry');

//route laporan
Route::get('laporan/getTransaksiCabang', 'LaporanController@getTransaksiCabang');
Route::get('laporan/getStockCabangAll', 'LaporanController@getStockCabangAll');
Route::get('laporan/getStockCabang', 'LaporanController@getStockCabang');
