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
				'id_server' => $request->id_server_master,
				'id_transaksi_laundry' => $request->id_transaksi_laundry_master,
				'id_cabang' => $request->id_cabang,
				'id_pelanggan' => $request->id_pelanggan,
				'tanggal' => $request->tanggal,
				'is_paid' => $request->is_paid,
				'is_taken' => $request->is_taken,
				'waktu_pengambilan' => $request->waktu_pengambilan,
				'created_at' => $request->created_at_master,
				'updated_at' => $request->updated_at_master
			]);

			DB::table('detail_laundry')->insert([
				'id_server' => $request->id_server_detail,
				'id_transaksi_laundry' => $request->id_transaksi_laundry_master,
				'id_detail_laundry' => $request->id_detail_laundry,
				'id_menu' => $request->id_menu,
				'id_harga_menu' => $request->id_harga_menu,
				'quantity' => $request->quantity,
				'real_quantity' => $request->real_quantity,
				'info' => $request->info,
				'created_at' => $request->created_at_detail,
				'updated_at' => $request->updated_at_detail
			]);

			$data_aktivitas = json_decode($request->aktivitas, true);

			DB::table('aktivitas_laundry')->insert(
				$data_aktivitas
			);

			
		$response = [
			'errorCode' => 0,
			'data' => null
		];

		return response()->json($response, 200);
	}

	public function get_transaksi_laundry_other_server(Request $request){
		
		$data = DB::table('transaksi_laundry')->get();

		$response = [
			'errorCode' => 0,
			'data' => $data
		];

		return response()->json($response, 200);
	}

	public function get_detail_transaksi_laundry_other_server(Request $request){
		
		$data = DB::table('detail_laundry')->get();

		$response = [
			'errorCode' => 0,
			'data' => $data
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

		$data_aktivitas = DB::table('aktivitas_laundry')->where('id_detail_laundry', $data_detail_id->id_detail_transaksi_laundry)->get()->toJson();

		
		//insert ke server lain

		$client = new Client(['http_errors' => false]); //GuzzleHttp\Client

		foreach($other_ip as $key => $value){

			try{
				$transaksi_1 = $client->post("http://".$value.":8000/api/transaksi/other_server/insert_transaksi_laundry", [
						'form_params' => [
							'id_server_master' => $data_transaksi->id_server,
							'id_transaksi_laundry_master' => $data_transaksi->id_transaksi_laundry,
							'id_cabang' => $data_transaksi->id_cabang,
							'id_pelanggan' => $data_transaksi->id_pelanggan,
							'tanggal' => $data_transaksi->tanggal,
							'is_paid' => $data_transaksi->is_paid,
							'is_taken' => $data_transaksi->is_taken,
							'waktu_pengambilan' => $data_transaksi->waktu_pengambilan,
							'created_at_master' => $data_transaksi->created_at,
							'updated_at_master' => $data_transaksi->updated_at,
							'id_server_detail' => $data_detail->id_server,
							'id_transaksi_laundry_detail' => $data_detail->id_transaksi_laundry,
							'id_detail_laundry' => $data_detail->id_detail_laundry,
							'id_menu' => $data_detail->id_menu,
							'id_harga_menu' => $data_detail->id_harga_menu,
							'quantity' => $data_detail->quantity,
							'real_quantity' => $data_detail->real_quantity,
							'info' => $data_detail->info,
							'created_at_detail' => $data_transaksi->created_at,
							'updated_at_detail' => $data_transaksi->updated_at,
							'aktivitas' => $data_aktivitas
						]
					]);

				$status = $transaksi_1->getStatusCode();
				
				
				if($status == 200){
				

				}else{
					// The server responded with some error. You can throw back your exception
					// to the calling function or decide to handle it here

					throw new \Exception('Failed');
				}
			}
			catch(\Guzzle\Http\Exception\ConnectException $e){
				
			}
			catch(\Exception $ex){

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

		
		$other_ip = get_server($request->id_server); //GuzzleHttp\Client


		foreach($other_ip as $key => $value){
			try{
				$self_transaksi = DB::table('transaksi_laundry')->select('id_server', 'id_transaksi_laundry')->get();

				$client = new Client(['http_errors' => false]);
				
				$response_transaksi = $client->get("http://".$value.":8000/api/transaksi/other_server/get_transaksi_laundry_other_server");
				if($response_transaksi->getStatusCode()==200){
					$content_transaksi = json_decode($response_transaksi->getBody()->getContents());
					
				
					$where = array();
					foreach($content_transaksi->data as $d){

						$arrayData = (array)$d;
						$exists = DB::table('transaksi_laundry')
						->where("id_server", $d->id_server)->where("id_transaksi_laundry",$d->id_transaksi_laundry)->first();

						if($exists == null){
							DB::table("transaksi_laundry")
								->insert(
									$arrayData	
								);
						} else {

						}

					}
					$response_detail_transaksi = $client->get("http://".$value.":8000/api/transaksi/other_server/get_detail_transaksi_laundry_other_server");
					if($response_detail_transaksi->getStatusCode()==200){
						$content_detail_transaksi = json_decode($response_detail_transaksi->getBody()->getContents());
						
					
						$where = array();
						foreach($content_detail_transaksi->data as $det){

							$arrayDataDetail = (array)$det;
							$exists = DB::table('detail_laundry')
							->where("id_server", $det->id_server)->where("id_detail_laundry",$det->id_detail_laundry)->first();

							if($exists == null){
								DB::table("detail_laundry")
									->insert(
										$arrayDataDetail
									);
							} else {

							}

						}

						$response_detail_transaksi = $client->get("http://".$value.":8000/api/aktivitaslaundry/other_server/get_aktivitas_laundry_other_server");
						if($response_detail_transaksi->getStatusCode()==200){
							$content_aktivitas = json_decode($response_detail_transaksi->getBody()->getContents());
							
						
							$where = array();
							foreach($content_aktivitas->data as $akt){

								$arrayDataAktivitas = (array)$akt;
								$exists = DB::table('aktivitas_laundry')
								->where("id_server", $akt->id_server)->where("id_aktivitas_laundry",$akt->id_aktivitas_laundry)->first();

								if($exists == null){
									DB::table("aktivitas_laundry")
										->insert(
											$arrayDataAktivitas
										);
								} else {

								}

							}
						}
					}		
				}
			}
			catch(\Exception $e){

			}

			// try{
			// 	$response_transaksi = $client->get("http://".$value.":8000/api/transaksi/other_server/get_detail_transaksi_laundry_other_server");

			// 	if($response_transaksi->getStatusCode()==200){
			// 		$content_transaksi = json_decode($response_transaksi->json());

			// 		$where = array();
			// 		foreach($content_transaksi as $d){
			// 			array_push($where, [
			// 				"id_server" => $d["id_server"],
			// 				"id_detail_laundry" => $d["id_detail_laundry"]
			// 			]);
			// 		}

			// 		if(!empty($where)){
			// 			$get = DB::table('detail_laudry')
			// 					->whereRaw(
			// 						whereNotInMultipleColumn(
			// 							["id_server", "id_detail_laundry"], 
			// 							$where
			// 							)
			// 						)->get()->toArray();
			// 			if(!empty($get)){
			// 				DB::table('detail_laundry')
			// 					->insert($get);
			// 			}

			// 		}
			// 	}		
			// }
			// catch(\Exception $e){

			// }

			// try{
			// 	$response_transaksi = $client->get("http://".$value.":8000/api/aktivitaslaundry/other_server/get_aktivitas_laundry_other_server");

			// 	if($response_transaksi->getStatusCode()==200){
			// 		$content_transaksi = json_decode($response_transaksi->json());

			// 		$where = array();
			// 		foreach($content_transaksi as $d){
			// 			array_push($where, [
			// 				"id_server" => $d["id_server"],
			// 				"id_aktivitas_laundry" => $d["id_aktivitas_laundry"]
			// 			]);
			// 		}

			// 		if(!empty($where)){
			// 			$get = DB::table('aktivitas_laundry')
			// 					->whereRaw(
			// 						whereNotInMultipleColumn(
			// 							["id_server", "id_aktivitas_laundry"], 
			// 							$where
			// 							)
			// 						)->get()->toArray();
			// 			if(!empty($get)){
			// 				DB::table('aktivitas_laundry')
			// 					->insert($get);
			// 			}

			// 		}
			// 	}		
			// }
			// catch(\Exception $e){

			// }
			
		}


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