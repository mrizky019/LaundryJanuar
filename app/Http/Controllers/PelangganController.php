<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Pelanggan;
use DB;

class pelangganController extends Controller
{
    public function store(Request $request, Pelanggan $pelanggan)
    {
    	$pelangganIsExist = DB::table('pelanggan')->where('email',$request->email)->first();

    	if ($pelangganIsExist) {

    		return response()->json(['errorCode' => -1,'message' => 'Email was taken'], 409);

    	} else {

    		$pelangganResponse 	= $pelanggan->create([
    			'id_pelanggan'	=> $request->id_pelanggan,
				'nama' 			=> $request->nama,
				'email' 		=> $request->email,
				'no_telepon'	=> $request->no_telepon,
				'alamat'		=> $request->alamat
			]);

    		$response = [
				'errorCode' => 0,
				'data' 		=> [
					'id_pelanggan'	=> $request->id_pelanggan,
					'nama' 			=> $request->nama,
					'email' 		=> $request->email,
					'no_telepon'	=> $request->no_telepon,
					'alamat'		=> $request->alamat
				]
			];

    	}

		return response()->json($response, 200);
    }

    public function search(Request $request)
    {
		$data = $request->data;

		$result = DB::table('pelanggan')
					->select('nama','email','no_telepon','alamat')
					->where('nama', 'like', '%'.$data.'%')
					->orWhere('email', 'like', '%'.$data.'%')
					->orWhere('no_telepon', 'like', '%'.$data.'%')
					->get();

		if ($result->isEmpty()) {
    		return response()->json(['errorCode' => -1,'message' => 'pelanggan tidak ditemukan'], 404);
	
		} else {
        	$response = [
				'errorCode' => 0,
				'data' 		=> $result
			];
		
		}

        return response()->json($response, 200);
    }
}
