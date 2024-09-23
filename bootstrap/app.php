<?php

use App\Http\Middleware\CheckAccountType;
use App\Http\Middleware\CustomerService;
use App\Http\Middleware\ServiceInspector;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        api: __DIR__ . '/../routes/api.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->api(prepend: [
            \Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful::class,
        ]);

        $middleware->alias([
            'verified' => \App\Http\Middleware\EnsureEmailIsVerified::class,
            'CheckAdmin' => CheckAccountType::class,
            'serviceinspector' => ServiceInspector::class,
            "customerservice" => CustomerService::class,
        ]);



        //
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
