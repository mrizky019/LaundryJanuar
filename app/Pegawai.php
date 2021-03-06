<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Pegawai extends Model
{
    public $table = 'pegawai';
	public $timestamps = false;
	protected $primaryKey = 'id_pegawai';
	public $incrementing = false;

    protected $fillable = [
    	'id_pelanggan',
    	'id_cabang',
    	'nama',
    	'alamat',
    	'no_telp',
    	'is_active'
    ];
}
