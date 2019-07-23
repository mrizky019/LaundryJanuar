<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;


class TransaksiController extends Controller
{

    public function store(Request $request)
    {
		$params = '@o_id_transaksi_laundry';

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
}
