<template>

    <Head :title="title ? title : 'EMart'">

        <link rel="apple-touch-icon" sizes="180x180" href="../../src/images/favicon.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="../../src/images/favicon.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="../../src/images/favicon.png" />
        <link rel="mask-icon" href="../../src/images/favicon.png" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <slot name="meta_head" />
    </Head>
    <main>
        <SideBar />
        <div class="page-content">
            <NavBar />
            <div class="page-content-wrapper p-xxl-4">
                <div class="row">
                    <div class="col-12 mb-4 mb-sm-5">
                        <div class="d-sm-flex justify-content-between align-items-center">
                            <h1 class="h3 mb-2 mb-sm-0">
                                <slot name="page-title" />
                            </h1>
                            <div class="d-grid">
                                <slot name="page-actions" />
                            </div>
                        </div>
                    </div>
                </div>
                <slot name="content" />
            </div>
        </div>
        <slot name="modals" />

        <slot name="preloader" />
    </main>
</template>

<script setup>
import NavBar from '@/Components/Main/NavBar.vue'
import SideBar from '@/Components/Main/SideBar.vue'
import { Head } from "@inertiajs/vue3";
import Logo from '../../src/images/logo.svg';
import PreLoader from '@/Components/Features/PreLoader.vue';

defineProps({
    title: String,
});
</script>

<style lang="scss">
.table-footer {
    padding-left: 5px;
    padding-right: 5px;
}
</style>
