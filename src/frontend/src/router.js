import { createRouter, createWebHistory } from "vue-router";

import Appointments from "@/pages/Admin/Appointments.page.vue";
import DailyReport from "@/pages/Reports/DailyReport.page.vue";
import HomePage from "@/pages/HomePage.vue";
import LoginPage from "@/pages/LoginPage.vue";
import RetailOutlets from "@/pages/Admin/RetailOutlets.page.vue";
import Salers from "@/pages/Admin/Salers.page.vue";
import Users from "@/pages/Admin/Users.page.vue";

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
            path: "/reports",
            meta: {
                label: "Отчеты"
            },
            children: [
                {
                    path: "daily_report",
                    component: DailyReport,
                    meta: {
                        label: "Ежедневные отчеты"
                    }
                }
            ]
        },
        {
            path: "/admin",
            meta: {
                label: "Админка"
            },
            children: [
                {
                    path: "users",
                    component: Users,
                    meta: {
                        label: "Пользователи"
                    }
                },
                {
                    path: "salers",
                    component: Salers,
                    meta: {
                        label: "Продавцы"
                    }
                },
                {
                    path: "retailoutlets",
                    component: RetailOutlets,
                    meta: {
                        label: "Торговые точки"
                    }
                },
                {
                    path: "appointments",
                    component: Appointments,
                    meta: {
                        label: "Назначения"
                    }
                }
            ]
        }
    ]
});


export default router;
