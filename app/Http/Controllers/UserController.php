<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Transformers\UserTransformer;

class UserController extends Controller 
{
    public function show(User $user)
    {
    	$users = $user->all();

    	$response = [
			'errorCode' => 0,
			'data' => $users			
		];

		return response()->json($users, 200);

    }
}
