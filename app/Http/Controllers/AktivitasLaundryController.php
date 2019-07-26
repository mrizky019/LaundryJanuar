<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
class AktivitasLaundryController extends Controller
{

    public function insert_aktivitas_laundry($data)
    {
        
    }

    public function show(Request $request){
        $data = DB::table("view_get_aktivitas_laundry")->where("id_transaksi_laundry", $request->id_transaksi_laundry)
                    ->get();

        $response = [
			'errorCode' => 0,
			'data' => $data			
		];

		return response()->json($response, 200);
    }

    public function melakukanAktivitasLaundry(Request $request){
        $data = DB::statement('CALL procedure_mengerjakan_aktivitas_laundry(:p_id_aktivitas_laundry, :p_id_pegawai)',
        array(
            'p_id_aktivitas_laundry' => $request->id_aktivitas_laundry,
            'p_id_pegawai' => $request->id_pegawai
        ));

        $aktivitas = DB::table("view_get_aktivitas_laundry")->where("id_aktivitas_laundry", $request->id_aktivitas_laundry)
                    ->get()[0];

        $response = [
            'errorCode' => 0,
            'data' => $aktivitas
        ];

        return response()->json($response, 200);
    }

    public function menyelesaikanAktivitasLaundry(Request $request){
        $data = DB::statement('CALL procedure_menyelesaikan_aktivitas_laundry(:p_id_aktivitas_laundry)',
        array(
            'p_id_aktivitas_laundry' => $request->id_aktivitas_laundry
        ));

        $aktivitas = DB::table("view_get_aktivitas_laundry")->where("id_aktivitas_laundry", $request->id_aktivitas_laundry)
                    ->get()[0];

        $response = [
            'errorCode' => 0,
            'data' => $aktivitas
        ];

        return response()->json($response, 200);
    }
}
