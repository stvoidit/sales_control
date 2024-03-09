import { createRouter, createWebHistory } from "vue-router";

import Admin from "@/pages/Admin/index.vue";
import HomePage from "@/pages/HomePage.vue";
import LoginPage from "@/pages/LoginPage.vue";

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/",
            component: HomePage
        },
        {
            path: "/login",
            component: LoginPage
        },
        {
            path: "/admin",
            component: Admin
        }
    ]
});


router.beforeEach((to, from, next) => {
    next();
});


export default router;
