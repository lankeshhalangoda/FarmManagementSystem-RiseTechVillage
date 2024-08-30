import './bootstrap';
import '../css/app.css';

import 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js';
import '../src/vendor/bootstrap/dist/js/bootstrap.bundle.min.js';
import '../src/vendor/overlay-scrollbar/js/overlayscrollbars.min.js';
import '../src/vendor/apexcharts/js/apexcharts.min.js';
import '../src/js/functions.js';

import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
