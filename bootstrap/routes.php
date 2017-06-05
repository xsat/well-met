<?php

use App\v1_0\Controllers\AuthorizationController;
use App\v1_0\Controllers\MemberController;
use App\v1_0\Controllers\PasswordController;
use App\v1_0\Controllers\SettingsController;
use Nen\Http\Request;
use Nen\Router\Group;
use Nen\Router\Groups;
use Nen\Router\Route;

return new Groups('api/1.0', [
    new Group(null, [
        new Route(AuthorizationController::class, 'login', 'login', Request::METHOD_POST),
        new Route(AuthorizationController::class, 'logout', 'logout', Request::METHOD_POST),
        new Route(AuthorizationController::class, 'confirm', 'confirm', Request::METHOD_POST),
    ]),
    new Group('member', [
        new Route(MemberController::class, 'view', 'member/([0-9]+)', Request::METHOD_GET),
        new Route(MemberController::class, 'create', null, Request::METHOD_POST),
        new Route(MemberController::class, 'update', null, Request::METHOD_PUT),
        new Route(MemberController::class, 'delete', null, Request::METHOD_DELETE),
    ]),
    new Group('password', [
        new Route(PasswordController::class, 'reset', null, Request::METHOD_POST),
        new Route(PasswordController::class, 'update', null, Request::METHOD_PUT),
    ]),
    new Group('settings', [
        new Route(SettingsController::class, 'member', 'member', Request::METHOD_POST),
        new Route(SettingsController::class, 'privacy', 'privacy', Request::METHOD_POST),
        new Route(SettingsController::class, 'email', 'email', Request::METHOD_POST),
        new Route(SettingsController::class, 'password', 'password', Request::METHOD_POST),
    ]),
]);
