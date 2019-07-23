<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Pelanggan;
use DB;

class pelangganController extends Controller
{

	public function show(Pelanggan $pelanggan)
	{
		$pelanggan = $pelanggan->all();

		$response = [
			'errorCode' => 0,
			'data' => $pelanggan			
		];

		return response()->json($response, 200);
	}

    public function store(Request $request)
    {
    	$pelangganIsExist = DB::table('pelanggan')->where('email',$request->email)->first();

    	if ($pelangganIsExist) {

    		return response()->json(['errorCode' => -1, 'data' => null], 200);

    	} else {

    		$params = '@o_id_pelanggan';

			DB::statement("CALL procedure_new_pelanggan(:email, :nama, :no_telepon, :alamat, @o_id_pelanggan)",
				array(
					'email' => $request->email,
					'nama' => $request->nama,
					'no_telepon' => $request->no_telepon,
					'alamat' => $request->alamat
				)
    		);

			$result = DB::select('select * from pelanggan where id_pelanggan = @o_id_pelanggan')[0];    		

    		$response = [
				'errorCode' => 0,
				'data' 		=> $result
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

    public function update(Request $request)
    {

		$pelanggan = Pelanggan::find($request->id_pelanggan);
		$pelangganEmail = Pelanggan::where('email', $request->email)->get()[0];


		if($pelanggan->email == $request->email || $pelangganEmail == null){
			$pelanggan->fill($request->all());

			$pelanggan->save();

			$response = [
				'errorCode' => 0,
				'data'	=> [
					'id_pelanggan'	=> $request->id_pelanggan,
					'email'			=> $pelanggan->email,
					'nama'			=> $pelanggan->nama,
					'no_telepon' 	=> $pelanggan->no_telepon,
					'alamat'		=> $pelanggan->alamat,
				]
			];
			return response()->json($response, 200);

		} else {
			return response()->json(['errorCode' => -1, 'data' => null]);
		}
    }

    public function destroy($id_pelanggan)
    {
   		$result = DB::table('transaksi_laundry')
		            ->join('pelanggan', 'transaksi_laundry.id_pelanggan', '=', 'pelanggan.id_pelanggan')
		            ->select(DB::raw('transaksi_laundry.id_pelanggan as id_pelanggan'))
		            ->where('transaksi_laundry.id_pelanggan', $id_pelanggan)
		            ->get();

		if ($result->isEmpty()) {
			$pelanggan = Pelanggan::find($id_pelanggan);
			$pelanggan->delete();

			return response()->json(['errorCode' => 0, 'data'=>null], 200);
		} else {
			return response()->json(['errorCode' => -1, 'data' => null], 200);

		}


    }
}