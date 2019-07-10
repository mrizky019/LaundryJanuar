<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Transformers\UserTransformer;

class UserController extends Controller 
{
    public function users(User $user)
    {
    	$users = $user->all();

    	$response = fractal()
			->collection($users)
			->transformWith(new UserTransformer)
			->toArray();

		return response()->json($response, 201);
    }
}
