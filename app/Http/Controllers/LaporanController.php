<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use GuzzleHttp\Exception\GuzzleException;
use GuzzleHttp\Client;

class LaporanController extends Controller
{

	public function __construct()
	{
        $this->middleware('auth');
	}

	public function viewTransactionReport(Request $request)
	{
		$other_ip = get_server($request->id_server); //GuzzleHttp\Client

		foreach($other_ip as $key => $value){
			try{
				$self_transaksi = DB::table('transaksi_laundry')->select('id_server', 'id_transaksi_laundry')->get();

				$client = new Client(['http_errors' => false]);
				
				$response_transaksi = $client->get("http://".$value."/api/transaksi/other_server/get_transaksi_laundry_other_server");
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
							if($d->updated_at != null){
								if($exists->updated_at != null){
									if(strtotime($exists->updated_at) < strtotime($d->updated_at)){
										DB::table("transaksi_laundry")
											->where('id_server', $d->id_server)
											->where('id_transaksi_laundry', $d->id_transaksi_laundry)
											->update($arrayData);

									}
								} else {
									$update = DB::table("transaksi_laundry")
											->where('id_server', $d->id_server)
											->where('id_transaksi_laundry', $d->id_transaksi_laundry)
											->update($arrayData);
								}
							}
						}
					}
					$response_detail_transaksi = $client->get("http://".$value."/api/transaksi/other_server/get_detail_transaksi_laundry_other_server");
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
								if($det->updated_at != null){
									if($exists->updated_at != null){
										if(strtotime($exists->updated_at) < strtotime($det->updated_at)){
											DB::table("detail_laundry")
												->where('id_server', $det->id_server)
												->where('id_detail_laundry', $det->id_detail_laundry)
												->update($arrayDataDetail);
										}
									} else {
										$update = DB::table("detail_laundry")
												->where('id_server', $det->id_server)
												->where('id_detail_laundry', $det->id_detail_laundry)
												->update($arrayDataDetail);
									}
								}
							}
						}

						$response_detail_transaksi = $client->get("http://".$value."/api/aktivitaslaundry/other_server/get_aktivitas_laundry_other_server");
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
									if($akt->updated_at != null){
										if($exists->updated_at != null){
											if(strtotime($exists->updated_at) < strtotime($akt->updated_at)){
												DB::table("aktivitas_laundry")
													->where('id_server', $akt->id_server)
													->where('id_aktivitas_laundry', $akt->id_aktivitas_laundry)
													->update($arrayDataAktivitas);
											}
										} else {
											$update = DB::table("aktivitas_laundry")
													->where('id_server', $akt->id_server)
													->where('id_aktivitas_laundry', $akt->id_aktivitas_laundry)
													->update($arrayDataAktivitas);
										}
									}
								}
							}
						}
					}		
				}
			}
			catch(\Exception $e){

			}
			
		}

		$result = DB::table('view_laporan_transaksi_cabang')
		->where('is_paid', 1)
		->Where('is_taken', 1)
		->orderBy('tanggal', 'desc')->get();

		return view('report.transaksi')->with('data', $result);
	}	

	public function viewBranchReport()
	{
		$stock = DB::select(DB::raw("CALL procedure_get_stock_all_cabang"));

		return view("report.cabang")->with('data',$stock);
	}	

}
