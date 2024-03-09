import { createRouter, createWebHistory } from "vue-router";

import HomePage from "@/pages/HomePage.vue";
import LoginPage from "@/pages/LoginPage.vue";

const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: "/",
            component: HomePage,
            meta: {
                label: "Главная страница"
            }
        },
        {
            path: "/login",
            component: LoginPage
        },
        {
            path: "/admin",
            meta: {
                label: "Админка"
            },
            children: [
                {
                    path: "/admin/users",
                    component: () => import("@/pages/Admin/pages/UsersPage.vue"),
                    meta: {
                        label: "Пользователи"
                    }
                },
                {
                    path: "salers",
                    component: () => import("@/pages/Admin/pages/SalersPage.vue"),
                    meta: {
                        label: "Продавцы"
                    }
                },
                {
                    path: "retailoutlets",
                    component: () => import("@/pages/Admin/pages/RetailOutletsPage.vue"),
                    meta: {
                        label: "Торговые точки"
                    }
                }
            ]
        }
    ]
});


router.beforeEach((to, from, next) => {
    next();
});


export default router;
