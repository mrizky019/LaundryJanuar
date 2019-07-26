<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;


class TransaksiController extends Controller
{
	public function insert_transaksi_laundry(Request $request){
		
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

			
		$response = [
			'errorCode' => 0,
			'data' => null
		];

		return response()->json($response, 200);
	}

	public function insert_detail_transaksi_laundry(Request $request){
		
		DB::table('detail_laundry')->insert([
			'id_server' => $request->id_server,
			'id_transaksi_laundry' => $request->id_transaksi_laundry,
			'id_detail_laundry' => $request->id_detail_laundry,
			'id_menu' => $request->id_menu,
			'id_harga_menu' => $request->id_harga_menu,
			'quantity' => $request->quantity,
			'real_quantity' => $request->real_quantity,
			'info' => $request->info,
			'created_at' => $request->created_at,
			'updated_at' => $request->updated_at
		]);

		$response = [
			'errorCode' => 0,
			'data' => null
		];

		return response()->json($response, 200);
	}

    public function store(Request $request)
    {
		$id_server = $request->id_server;

		$other_ip = get_server($id_server);

		DB::statement("CALL procedure_new_transaksi_laundry(:id_server, :id_cabang, :id_pelanggan, @o_id_transaksi_laundry)",
			array(
				'id_server' => $request->id_server,
				'id_cabang'=> $request->id_cabang,
				'id_pelanggan' => $request->id_pelanggan
			)	
		);

		$data_master_id = DB::select('select @o_id_transaksi_laundry as id_transaksi_laundry')[0];

		$data_transaksi = DB::table('transaksi_laundry')->where('id_transaksi_laundry', $data_master_id->id_transaksi_laundry)->first();

        DB::statement("CALL procedure_new_detail_laundry(:id_server, :id_transaksi_laundry, :id_menu, :real_quantity, :info, @o_id_detail_transaksi_laundry)", 
        	array(
				'id_server' => $id_server,
	        	'id_transaksi_laundry' => $data_master_id->id_transaksi_laundry,
	        	'id_menu'	=> $request->id_menu,
	        	'real_quantity'	=> $request->real_quantity,
	        	'info'	=> $request->info,
        	)
		);
		
		$data_detail_id = DB::select('select @o_id_detail_transaksi_laundry as id_detail_transaksi_laundry')[0];

		$data_detail = DB::table('detail_laundry')->where('id_detail_laundry', $data_detail_id->id_detail_transaksi_laundry)->first();

		//insert ke server lain

		$client = new Client(); //GuzzleHttp\Client

		foreach($other_ip as $key => $value){
			try{
				$transaksi_1 = $client->post("http://".$value.":8000/api/transaksi/other_server/insert_transaksi_laundry", [
						'form_params' => [
							'id_server' => $data_transaksi->id_server,
							'id_transaksi_laundry' => $data_transaksi->id_transaksi_laundry,
							'id_cabang' => $data_transaksi->id_cabang,
							'id_pelanggan' => $data_transaksi->id_pelanggan,
							'tanggal' => $data_transaksi->tanggal,
							'is_paid' => $data_transaksi->is_paid,
							'is_taken' => $data_transaksi->is_taken,
							'waktu_pengambilan' => $data_transaksi->waktu_pengambilan,
							'created_at' => $data_transaksi->created_at,
							'updated_at' => $data_transaksi->updated_at
						]
					]);
				$status = $transaksi_1->getStatusCode();
				if($status == 200){
					$detail_1 = $client->post("http://".$value.":8000/api/transaksi/other_server/insert_detail_transaksi_laundry", [
						'form_params' => [
							'id_server' => $data_detail->id_server,
							'id_transaksi_laundry' => $data_detail->id_transaksi_laundry,
							'id_detail_laundry' => $data_detail->id_detail_laundry,
							'id_menu' => $data_detail->id_menu,
							'id_harga_menu' => $data_detail->id_harga_menu,
							'quantity' => $data_detail->quantity,
							'real_quantity' => $data_detail->real_quantity,
							'info' => $data_detail->info,
							'created_at' => $data_detail->created_at,
							'updated_at' => $data_detail->updated_at
						]
					]);

				}else{
					// The server responded with some error. You can throw back your exception
					// to the calling function or decide to handle it here

					throw new \Exception('Failed');
				}
			}
			catch(\Guzzle\Http\Exception\ConnectException $e){
				
			}

		}


		
        $result = DB::table('view_laporan_transaksi_cabang')
        ->where('id_transaksi_laundry', $data_master_id->id_transaksi_laundry)->get()[0];

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