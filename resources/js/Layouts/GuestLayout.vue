<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <main>
        <section class="vh-xxl-100">
            <div class="container h-100 d-flex px-0 px-sm-4">
                <div class="row justify-content-center align-items-center m-auto">
                    <div class="col-12">
                        <div class="bg-mode shadow rounded-3 overflow-hidden mb-5">
                            <div class="row g-0">
                                <slot />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</template>
