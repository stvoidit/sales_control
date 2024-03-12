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
                    path: "users",
                    component: () => import("@/pages/Admin/pages/Users.page.vue"),
                    meta: {
                        label: "Пользователи"
                    }
                },
                {
                    path: "salers",
                    component: () => import("@/pages/Admin/pages/Salers.page.vue"),
                    meta: {
                        label: "Продавцы"
                    }
                },
                {
                    path: "retailoutlets",
                    component: () => import("@/pages/Admin/pages/RetailOutlets.page.vue"),
                    meta: {
                        label: "Торговые точки"
                    }
                },
                {
                    path: "appointments",
                    component: () => import("@/pages/Admin/pages/Appointments.page.vue"),
                    meta: {
                        label: "Назначения"
                    }
                }
            ]
        }
    ]
});


export default router;
