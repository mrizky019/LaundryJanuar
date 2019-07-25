<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class LaporanController extends Controller
{
	public function getTransaksiCabang(Request $request)
	{
		$trans = DB::statement("CALL procedure_get_laporan_transaksi_cabang(:p_date_from, :p_date_to)", array(
			'p_date_from' => $request->p_date_from,
			'p_date_to' => $request->p_date_to,
		));


		$result = DB::table('view_laporan_transaksi_cabang')->whereBetween('tanggal', array(
			$request->p_date_from, 
			$request->p_date_to
		))->get();

		$response = [
			'errorCode' => 0,
			'data'	=> $result
		];

		return response()->json($response, 200);
	}

	public function getStockCabangAll(Request $request)
	{
		$stock = DB::select("CALL procedure_get_stock_all_cabang");

		$response = [
			'errorCode' => 0,
			'data'	=> $stock
		];

		return response()->json($response, 200);
	}

	public function getStockCabang(Request $request)
	{
		$stock = DB::select("CALL procedure_get_stock_cabang(:id_cabang)", array(
			$request->id_cabang
		));

		$response = [
			'errorCode' => 0,
			'data'	=> $stock
		];

		return response()->json($response, 200);
	}
}
