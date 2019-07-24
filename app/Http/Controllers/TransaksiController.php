<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;


class TransaksiController extends Controller
{

    public function store(Request $request)
    {

		DB::statement("CALL procedure_new_transaksi_laundry(:id_cabang, :id_pelanggan, @o_id_transaksi_laundry)",
			array(
				'id_cabang'=> $request->id_cabang,
				'id_pelanggan' => $request->id_pelanggan
			)	
		);

    	$data = DB::select('select @o_id_transaksi_laundry as id_transaksi_laundry')[0];

        DB::statement("CALL procedure_new_detail_laundry(:id_transaksi_laundry, :id_menu, :real_quantity, :info)", 
        	array(
	        	'id_transaksi_laundry' => $data->id_transaksi_laundry,
	        	'id_menu'	=> $request->id_menu,
	        	'real_quantity'	=> $request->real_quantity,
	        	'info'	=> $request->info,
        	)
        );

        $result = DB::table('view_laporan_transaksi_cabang')
        ->where('id_transaksi_laundry', $data->id_transaksi_laundry)->get()[0];

        $response = [
        	'errorCode' => 0,
        	'data'	=> $result
        ];

        return response()->json($response, 200);
	}

	public function showUnfinished(Request $request){
		$result = DB::table('view_laporan_transaksi_cabang')
		->where('id_cabang', $request->id_cabang)
		->where('is_paid', '<>', 1)
		->where('is_taken', '<>', 1)->get();

		if ($result->isEmpty()) 
		{
    		return response()->json(['errorCode' => 0, 'data' => []], 200);
		}

        return response()->json(['errorCode' => 0, 'data' => $result], 200);
	}

	public function paidTransaction(Request $request){
		$paid = DB::statement("CALL procedure_paid_laundry(:id_transaksi)", array(
			"id_transaksi" => $request->id_transaksi
		));

		$response = [
			'errorCode' => 0,
			'data' => null
		];

		return response()->json($response, 200);
	}

	public function takeTransaction(Request $request){
		
		$exists = DB::table('transaksi_laundry')
				->where('id_transaksi_laundry', $request->id_transaksi)
				->first();
		

		if($exists == null){
			return response()->json(['errorCode' => -98, 'data' => null]);
		}

		if($exists->is_paid == 1){
			return response()->json(['errorCode' => -1, 'data' => null]);
		}

		$taken = DB::statement("CALL procedure_pengambilan_laundry(:id_transaksi)", array(
			"id_transaksi" => $request->id_transaksi
		));

		$response = [
			'errorCode' => 0,
			'data' => null
		];

		return response()->json($response, 200);
	}
}