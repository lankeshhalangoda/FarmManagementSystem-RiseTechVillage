<template>
    <nav class="navbar sidebar bg-warning bg-opacity-10 navbar-expand-xl navbar-light">
        <div class="d-flex align-items-center justify-content-center">
            <a class="navbar-brand d-flex justify-content-center" href="/">
                <img class="light-mode-item navbar-brand-item" src="../../../src/images/logo.svg"
                    style="width: 200px; height: auto;" alt="logo" />
                <img class="dark-mode-item navbar-brand-item" src="../../../src/images/logo.svg"
                    style="width: 200px; height: auto;" alt="logo" />
            </a>
        </div>

        <div class="offcanvas offcanvas-start flex-row custom-scrollbar h-100" data-bs-backdrop="true" tabindex="-1"
            id="offcanvasSidebar">
            <div class="offcanvas-body sidebar-content d-flex flex-column pt-4">
                <ul class="navbar-nav flex-column" id="navbar-sidebar">
                    <li class="nav-item">
                        <Link :href="route('dashboard')" class="nav-link"
                            :class="{ active: route().current('dashboard') }">
                        <i class="fa fa-home me-2"></i>
                        Dashboard
                        </Link>
                    </li>

                    <li class="nav-item">
                        <Link :href="route('crop')" class="nav-link" :class="{
                            active:
                                route().current('crop') ||
                                route().current('crop.*'),
                        }">
                        <i class="fa fa-Seedling me-2"></i>
                        Crops
                        </Link>
                    </li>

                    <li class="nav-item">
                        <Link :href="route('inventory')" class="nav-link" :class="{
                            active:
                                route().current('inventory') ||
                                route().current('inventory.*'),
                        }">
                        <i class="fa fa-box me-2"></i>
                        Inventory
                        </Link>
                    </li>

                    <li class="nav-item">
                        <Link :href="route('soil')" class="nav-link" :class="{
                            active:
                                route().current('soil') ||
                                route().current('soil.*'),
                        }">
                        <i class="fa fa-mountain me-2"></i>
                        Soil
                        </Link>
                    </li>

                </ul>
            </div>
        </div>
    </nav>
</template>

<script setup>
import { Link } from "@inertiajs/vue3";
</script>
