import './bootstrap';
import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router';
import App from './App.vue';

// Import components
import Login from './components/Login.vue';
import ItemsIndex from './components/Items/Index.vue';
import TransactionsIndex from './components/Transactions/Index.vue';
import ReportsIndex from './components/Reports/Index.vue';

const routes = [
    { path: '/login', component: Login, name: 'login', meta: { guest: true } },
    { path: '/', component: ItemsIndex, name: 'items.index', meta: { requiresAuth: true } },
    { path: '/transactions', component: TransactionsIndex, name: 'transactions.index', meta: { requiresAuth: true } },
    { path: '/reports', component: ReportsIndex, name: 'reports.index', meta: { requiresAuth: true } },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

// Navigation Guard
router.beforeEach((to, from, next) => {
    const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';

    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (!isLoggedIn) {
            next({ name: 'login' });
        } else {
            next();
        }
    } else if (to.matched.some(record => record.meta.guest)) {
        if (isLoggedIn) {
            next({ name: 'items.index' });
        } else {
            next();
        }
    } else {
        next();
    }
});

const app = createApp(App);
app.use(router);
app.mount('#app');
