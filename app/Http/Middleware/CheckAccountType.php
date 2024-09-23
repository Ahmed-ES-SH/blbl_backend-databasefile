<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class CheckAccountType
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (Auth::check()) {
            if (Auth::user()->role !== 'Admin') {
                return response()->json([
                    'message' => 'Access denied. Admins only.'
                ], 403);
            }
        } else {
            return response()->json([
                'message' => 'Unauthorized. Please log in.'
            ], 401);
        }

        return $next($request);
    }
}
