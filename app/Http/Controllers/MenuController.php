<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use DB;

class MenuController extends Controller
{
    public function show()
    {
    	$menu = DB::table('view_get_menu')->get();


		$response = [
			'errorCode' => 0,
			'data' => $menu			
		];

		return response()->json($response, 200);
    }
}
