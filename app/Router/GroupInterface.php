<?php

namespace App\Router;

/**
 * Interface GroupInterface
 */
interface GroupInterface
{
    /**
     * @return RouteInterface[]
     */
    public function getRoutes(): array;

    /**
     * @param RouteInterface $route
     *
     * @return GroupInterface
     */
    public function addRoute(RouteInterface $route): GroupInterface;

//    /**
//     * @return string
//     */
//    public function getPrefix(): string;
//
//    /**
//     * @param string $prefix
//     *
//     * @return GroupInterface
//     */
//    public function setPrefix(string $prefix): GroupInterface;
}
