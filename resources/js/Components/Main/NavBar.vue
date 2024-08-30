<template>
    <nav class="navbar top-bar navbar-light py-0 py-xl-3">
        <div class="container-fluid p-0">
            <div class="d-flex align-items-center w-100">
                <div class="navbar-expand-xl sidebar-offcanvas-menu">
                    <button class="navbar-toggler me-auto p-2" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar" aria-expanded="false"
                        aria-label="Toggle navigation" data-bs-auto-close="outside">
                        <i class="bi bi-list text-primary fa-fw" data-bs-target="#offcanvasMenu"></i>
                    </button>
                </div>

                <div class="navbar-expand-lg ms-auto ms-xl-0">

                    <button class="navbar-toggler ms-auto p-0" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarTopContent" aria-controls="navbarTopContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                        <i class="bi bi-search"></i>
                    </button>

                    <div class="collapse navbar-collapse w-100 z-index-1" id="navbarTopContent">
                    </div>
                </div>
                <div class="d-flex align-items-center d-xl-none">
                    <a class="navbar-brand" href="index.html">
                        <img class="navbar-brand-item h-40px" src="../../../src/images/logo.svg" alt="" />
                    </a>
                </div>

                <ul class="nav flex-row align-items-center list-unstyled ms-xl-auto">

                    <li class="nav-item dropdown ms-3">

                        <a class="nav-notification btn btn-light p-0 mb-0" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                            <i class="bi bi-bell fa-fw"></i>
                        </a>
                        <span class="notif-badge animation-blink"></span>

                        <div
                            class="dropdown-menu dropdown-animation dropdown-menu-end dropdown-menu-size-md shadow-lg p-0">
                            <div class="card bg-transparent">
                                <div
                                    class="card-header bg-transparent d-flex justify-content-between align-items-center border-bottom">
                                    <h6 class="m-0">
                                        Notifications
                                    </h6>
                                    <a class="small" href="#">Clear all</a>
                                </div>

                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush list-unstyled p-2">
                                    </ul>
                                </div>
                                <div class="card-footer bg-transparent text-center border-top">
                                    <a href="#" class="btn btn-sm btn-link mb-0 p-0">See all incoming activity</a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="nav-item ms-3 dropdown">
                        <a class="avatar avatar-sm p-0" href="#" id="profileDropdown" role="button"
                            data-bs-auto-close="outside" data-bs-display="static" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <img class="avatar-img rounded-2" src="../../../src/images/avatar/01.jpg" alt="avatar" />
                        </a>

                        <ul class="dropdown-menu dropdown-animation dropdown-menu-end shadow"
                            aria-labelledby="profileDropdown">
                            <li class="px-3 mb-1">
                                <div class="d-flex align-items-center">
                                    <div class="avatar me-3">
                                        <img class="avatar-img rounded-circle shadow"
                                            src="../../../src/images/avatar/01.jpg" alt="avatar" />
                                    </div>
                                    <div>
                                        <a class="h6 mt-2 mt-sm-0" href="#">{{ user.name }}</a>
                                        <p class="small m-0">
                                            {{ user.email }}
                                        </p>
                                    </div>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider" />
                            </li>

                            <li>
                                <Link class="dropdown-item bg-danger-soft-hover" href="/logout" method="post"
                                    as="button"><i class="bi bi-power fa-fw me-2"></i>Sign Out</Link>
                            </li>
                        </ul>
                    </li>
                </ul>

            </div>
        </div>
    </nav>
</template>

<script setup>
import { Link, usePage } from '@inertiajs/vue3';

const { props } = usePage();
const user = props.auth.user;
</script>
