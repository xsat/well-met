<?php

use App\Controllers\MemberController;
use App\Http\Request;
use App\Router\Group;
use App\Router\Route;

return new Group([
    new Route(MemberController::class, 'view', 'member/([0-9]+)', Request::METHOD_GET),

    new Route(MemberController::class, 'create', 'member', Request::METHOD_POST),
    new Route(MemberController::class, 'update', 'member', Request::METHOD_PUT),
    new Route(MemberController::class, 'delete', 'member', Request::METHOD_DELETE),

    new Route(MemberController::class, 'login', 'login', Request::METHOD_POST),
    new Route(MemberController::class, 'logout', 'logout', Request::METHOD_POST),

    new Route(MemberController::class, 'login', 'login', Request::METHOD_POST),
    new Route(MemberController::class, 'logout', 'logout', Request::METHOD_POST),

    new Route(MemberController::class, 'confirm', 'confirm', Request::METHOD_POST),

    new Route(MemberController::class, 'resetPassword', 'password', Request::METHOD_POST),
    new Route(MemberController::class, 'updatePassword', 'password', Request::METHOD_PUT),
]);
