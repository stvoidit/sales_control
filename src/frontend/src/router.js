import { createRouter, createWebHistory } from "vue-router";

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
        }
    ]
});


router.beforeEach((to, from, next) => {
    next();
});


export default router;
