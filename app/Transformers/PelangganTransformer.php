<?php 

namespace App\Transformers;

use App\Pelanggan;
use League\Fractal\TransformerAbstract;

/**
 * 
 */
class PelangganTransformer extends TransformerAbstract
{
	
	public function transform(Pelanggan $pelanggan)
	{
		return [
			'errorCode'		=> 0,
			'data'			=> [
				'id_pelanggan'	=> $pelanggan->id_pelanggan,
				'nama' 			=> $pelanggan->nama,
				'email' 		=> $pelanggan->email,
				'no_telepon' 	=> $pelanggan->no_telepon,
				'alamat' 		=> $pelanggan->alamat
			]
		];
	}
}