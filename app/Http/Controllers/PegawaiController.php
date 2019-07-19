<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Pegawai;
use DB;


class PegawaiController extends Controller
{
    public function show(Pegawai $pegawai)
    {
    	$pegawai = $pegawai->all();

		$response = [
			'errorCode' => 0,
			'data' => $pegawai			
		];

		return response()->json($response, 200);
    }

    public function store(Request $request)
    {
    	$params = '@o_id_pegawai';

    	DB::select("CALL procedure_new_pegawai(
    		'$request->id_cabang',
    		'$request->nama',
    		'$request->alamat',
    		'$request->no_telp',
    		'$request->is_active',
             $params
    	)");

        $result = DB::select('select * from pegawai where id_pegawai = @o_id_pegawai');

    	$response = [
			'errorCode' => 0,
			'data' 		=> $result
		];

		return response()->json($response, 200);
    }

    public function update(Request $request)
    {
    	$pegawai = Pegawai::find($id_pegawai);

		$pegawai->fill($request->all());

    	$pegawai->save();

    	$response = [
    		'errorCode' => 0,
    		'data'	=> [
    			'id_pegawai'	=> $request->id_pegawai,
				'id_cabang' 	=> $pegawai->id_cabang,
				'nama' 			=> $pegawai->nama,
				'alamat'		=> $pegawai->alamat,
				'no_telp'		=> $pegawai->no_telp,
				'is_active'		=> $pegawai->is_actve
    		]
    	];
    	return response()->json($response, 200);
    }

    public function destroy($id_pegawai)
    {
    	$result = DB::table('aktivitas_laundry')
            ->join('pegawai', 'aktivitas_laundry.id_pegawai', '=', 'pegawai.id_pegawai')
            ->select(DB::raw('aktivitas_laundry.id_pegawai as id_pegawai'))
            ->where('aktivitas_laundry.id_pegawai', $id_pegawai)
            ->get();

    	if ($result->isEmpty()) {
    		$pegawai = Pegawai::find($id_pegawai);
			$pegawai->delete();

			return response()->json(['errorCode' => 0, 'data' => []], 200);

    	} else {
    		$pegawai = Pegawai::find($id_pegawai);
    		DB::table('pegawai')
	            ->where('id_pegawai', $id_pegawai)
	            ->update(['is_actve' => 0]);

			return response()->json(['errorCode' => 0, 'data' => []], 200);
    	}
    }
}
