<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Pelanggan extends Model
{
	public $table = 'pelanggan';
	public $timestamps = false;

    protected $fillable = [
    	'id_pelanggan', 'email', 'nama', 'no_telepon', 'alamat'
    ];
}
