<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Transformers\UserTransformer;
use App\User;
use Auth;
use DB;

class AuthController extends Controller 
{
	private $errcode = 0;// 0 - success | 2000 - error | 3000 - warning

	public function register(Request $request, User $user) 
	{

    	$usersIsExist = DB::table('users')->where('email',$request->email)->first();

    	if ($usersIsExist) {
    		return response()->json(['errorCode' => -1], 200);

    	} else {

			$this->validate($request, [
				'name' 		=> 'required',
				'email'		=> 'required|email|unique:users', 
				'password'	=> 'required|min:6'
			]);

			$userResponse = $user->create([
				'name' 		=> $request->name,
				'email' 	=> $request->email,
				'password' 	=> bcrypt($request->password),
				'id_cabang'	=> $request->id_cabang
			]);

			$response = [
				'errorCode' => 0,
				'data' 		=> $userResponse
			];
    	}

		return response()->json($response, 201);
	}

	public function login(Request $request, User $user) 
	{
		if (!Auth::attempt([
			'email' => $request->email,
			'password' => $request->password
		])) {
			return response()->json(['errorCode' => -1,'data' => null], 200);
		}

		$user = $user->find(Auth::user()->id);

		if($user->id_cabang != null){
			$response = [
				'errorCode' => 0,
				'data' => [
					'email' => $user->email,
					'name' => $user->name,
					'id' => $user->id_cabang,
					'role' => 1
				]
			];
		} else {
			$response = [
				'errorCode' => 0,
				'data' => [
					'email' => $user->email,
					'name' => $user->name,
					'id' => $user->id_hq,
					'role' => 2
				]
			];
		}

		return response()->json($response, 200);
	}
}
