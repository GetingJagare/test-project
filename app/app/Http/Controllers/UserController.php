<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegistrationRequest;
use App\Http\Resources\UserResource;
use App\Models\User;

class UserController extends Controller
{
    public function register(RegistrationRequest $request)
    {
        // Create a new user
        User::create([
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'gender' => $request->gender
        ]);

        // Return a response
        return response()->json(['success' => true], 201);
    }

    public function profile($id)
    {
        // Find the user by ID
        $user = User::find($id);

        // Return the user data
        return $user ? response()->json(new UserResource($user))
            : response()->json(['error' => 'User not found'], 404);
    }
}
