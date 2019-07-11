<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Transformers\PelangganTransformer;
use App\Pelanggan;
use DB;

class pelangganController extends Controller
{

	public function getPelanggan(Pelanggan $pelanggan)
	{
		$pelanggan = $pelanggan->all();

		$response = [
			'errorCode' => 0,
			'data' => $pelanggan			
		];

		return response()->json($response, 200);
	}

    public function store(Request $request, Pelanggan $pelanggan)
    {
    	$pelangganIsExist = DB::table('pelanggan')->where('email',$request->email)->first();

    	if ($pelangganIsExist) {

    		return response()->json(['errorCode' => -1, 'data' => []], 200);

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
		$params = $request->get('q');

		$result = Pelanggan::where('nama', 'like', '%'.$params.'%')
					->orWhere('email', 'like', '%'.$params.'%')
					->orWhere('no_telepon', 'like', '%'.$params.'%')
					->get();

		if ($result->isEmpty()) 
		{
    		return response()->json(['errorCode' => 0, 'data' => []], 200);
		}

        return response()->json(['errorCode' => 0, 'data' => $result], 200);
    }
}
