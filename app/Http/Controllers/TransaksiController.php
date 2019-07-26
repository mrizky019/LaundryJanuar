<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;


class TransaksiController extends Controller
{

	private function get_server($id){
		$other_ip = [];
		foreach(config('app.IP_SERVER') as $key => $value){
			if($key != $id-1){
				array_push($other_ip, $value);
			}
		}
		return $other_ip;
	}

	public function insert_transaksi_laundry(Request $request){
		try{
			DB::table('transaksi_laundry')->insert([
				'id_server' => $request->id_server,
				'id_transaksi_laundry' => $request->id_transaksi_laundry,
				'id_cabang' => $request->id_cabang,
				'id_pelanggan' => $request->id_pelanggan,
				'tanggal' => $request->tanggal,
				'is_paid' => $request->is_paid,
				'is_taken' => $request->is_taken,
				'waktu_pengambilan' => $request->waktu_pengambilan,
				'created_at' => $request->created_at,
				'updated_at' => $request->updated_at
			]);

		}
		catch(Exception $e){

		}
	}

	public function insert_detail_transaksi_laundry(Request $request){
		try{
			DB::table('detail_laundry')->insert([
				'id_server' => $request->id_server,
				'id_detail_laundry' => $request->id_transaksi_laundry,
				'id_transaksi_laundry' => $request->id_cabang,
				'id_menu' => $request->id_pelanggan,
				'id_harga_menu' => $request->tanggal,
				'quantity' => $request->is_paid,
				'real_quantity' => $request->is_taken,
				'waktu_pengambilan' => $request->waktu_pengambilan,
				'created_at' => $request->created_at,
				'updated_at' => $request->updated_at
			]);

		}
		catch(Exception $e){

		}
	}

    public function store(Request $request)
    {
		$id_server = $request->id_server;

		$other_ip = $this.get_server($id_server);

		DB::statement("CALL procedure_new_transaksi_laundry(:id_cabang, :id_pelanggan, :id_server, @o_id_transaksi_laundry)",
			array(
				'id_server' => $request->id_server,
				'id_cabang'=> $request->id_cabang,
				'id_pelanggan' => $request->id_pelanggan
			)	
		);

		$inserted_transaksi_id = DB::select('select @o_id_transaksi_laundry as id_transaksi_laundry')[0];

		$data_transaksi = DB::table('transaksi_laundry')->where('id_transaksi_laundry', $inserted_id)->first();

        DB::statement("CALL procedure_new_detail_laundry(:id_server, :id_transaksi_laundry, :id_menu, :real_quantity, :info, @o_id_detail_transaksi_laundry)", 
        	array(
				'id_server' => $id_server,
	        	'id_transaksi_laundry' => $data->id_transaksi_laundry,
	        	'id_menu'	=> $request->id_menu,
	        	'real_quantity'	=> $request->real_quantity,
	        	'info'	=> $request->info,
        	)
		);
		
		$inserted_detail_transaksi_id = DB::select('select @o_id_detail_transaksi_laundry as id_detail_transaksi_laundry')[0];

		$data_detail = DB::table('detail_laundry')->where('id_detail_laundry', $inserted_detail_transaksi_id);

		//insert ke server lain

		$client = new Client(); //GuzzleHttp\Client

		foreach(get_server($id_server) as $key => $value){
			$result = $client->post($value.":8000/api/transaksi/other_server/insert_transaksi_laundry", [
						$data_transaksi
					]);
		}


		
        $result = DB::table('view_laporan_transaksi_cabang')
        ->where('id_transaksi_laundry', $data->id_transaksi_laundry)->get()[0];

        $response = [
        	'errorCode' => 0,
        	'data'	=> $result
        ];

        return response()->json($response, 200);
	}

	public function getTransaction(Request $request){
		$result = DB::table('view_laporan_transaksi_cabang')
		->where('id_transaksi_laundry', $request->id_transaksi_laundry)->first();

		$response = [
			'errorCode' => 0,
			'data' => $result
		];

		return response()->json($response, 200);
	}

	public function showUnfinished(Request $request){
		$result = DB::table('view_laporan_transaksi_cabang')
		->where('id_cabang', $request->id_cabang)
		->where('is_paid', '<>', 1)
		->orWhere('is_taken', '<>', 1)
		->orderBy('tanggal', 'desc')->get();

		if ($result->isEmpty()) 
		{
    		return response()->json(['errorCode' => 0, 'data' => []], 200);
		}

        return response()->json(['errorCode' => 0, 'data' => $result], 200);
	}

	public function paid(Request $request){
		$paid = DB::statement("CALL procedure_paid_laundry(:id_transaksi)", array(
			"id_transaksi" => $request->id_transaksi
		));


		$result = DB::table('view_laporan_transaksi_cabang')
				->where('id_transaksi_laundry', $request->id_transaksi)
				->first();

		$response = [
			'errorCode' => 0,
			'data' => $result
		];

		return response()->json($response, 200);
	}

	public function take(Request $request){
		
		$exists = DB::table('transaksi_laundry')
				->where('id_transaksi_laundry', $request->id_transaksi)
				->first();
		

		if($exists == null){
			return response()->json(['errorCode' => -98, 'data' => null]);
		}

		if($exists->is_paid == 0){
			return response()->json(['errorCode' => -1, 'data' => null]);
		}

		$taken = DB::statement("CALL procedure_pengambilan_laundry(:id_transaksi)", array(
			"id_transaksi" => $request->id_transaksi
		));

		$result = DB::table('view_laporan_transaksi_cabang')
				->where('id_transaksi_laundry', $request->id_transaksi)
				->first();
		

		$response = [
			'errorCode' => 0,
			'data' => $result
		];

		return response()->json($response, 200);
	}

	public function showFinishedTransaction(Request $request){
		$result = DB::table('view_laporan_transaksi_cabang')
		->where('id_cabang', $request->id_cabang)
		->where('is_paid', 1)
		->Where('is_taken', 1)
		->orderBy('tanggal', 'desc')->get();

		if ($result->isEmpty()) 
		{
    		return response()->json(['errorCode' => 0, 'data' => []], 200);
		}

        return response()->json(['errorCode' => 0, 'data' => $result], 200);
	
	}
}