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

    	DB::select("CALL procedure_new_transaksi_laundry(
    		'$request->id_cabang',
    		'$request->id_pelanggan',
    		 $params
    	)");

    	$data = DB::select('select @o_id_transaksi_laundry as id_transaksi_laundry')[0];

        DB::select("CALL procedure_new_detail_laundry(
        	'$data->id_transaksi_laundry',
        	'$request->id_menu',
        	'$request->real_quantity',
        	'$request->info'
        )");

        $result = DB::table('view_laporan_transaksi_cabang')
        ->where('id_transaksi_laundry', $data->id_transaksi_laundry)->get();

        $response = [
        	'errorCode' => 0,
        	'data'	=> $result
        ];

        return response()->json($response, 200);
    }
}
