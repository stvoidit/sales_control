<template>
    <q-header
        bordered
        class="bg-white text-black">
        <q-toolbar>
            <q-btn
                v-if="$q.screen.lt.md"
                flat
                round
                icon="menu"
                class="q-mr-sm">
                <q-menu>
                    <q-list style="min-width: 100px">
                        <template
                            v-for="r in menuRoutes"
                            :key="r.path">
                            <q-item
                                v-if="r.meta && !r.children"
                                v-close-popup
                                :to="r.path"
                                exact
                                clickable>
                                <q-item-section>{{ r.meta.label }}</q-item-section>
                            </q-item>
                            <q-item
                                v-if="r.meta && r.children"
                                clickable>
                                <q-item-section>{{ r.meta.label }}</q-item-section>
                                <q-item-section side>
                                    <q-icon name="keyboard_arrow_right" />
                                </q-item-section>
                                <q-menu
                                    anchor="top end"
                                    self="top start">
                                    <q-list>
                                        <q-item
                                            v-for="sr in r.children"
                                            :key="sr.path"
                                            :to="sr.path"
                                            exact
                                            clickable>
                                            <q-item-section>{{ sr.meta.label }}</q-item-section>
                                        </q-item>
                                    </q-list>
                                </q-menu>
                            </q-item>
                        </template>
                    </q-list>
                </q-menu>
            </q-btn>
            <q-tabs
                v-else
                v-model="tab"
                align="left"
                inline-label>
                <template
                    v-for="r in menuRoutes"
                    :key="r.path">
                    <q-route-tab
                        v-if="r.meta && !r.children"
                        :to="r.path"
                        exact
                        :label="r.meta.label" />
                    <q-btn-dropdown
                        v-if="r.meta && r.children"
                        :key="r.path"
                        auto-close
                        stretch
                        flat
                        :label="r.meta.label">
                        <q-list>
                            <q-item
                                v-for="sr in r.children"
                                :key="sr.path"
                                :to="sr.path"
                                exact
                                clickable>
                                <q-item-section>{{ sr.meta.label }}</q-item-section>
                            </q-item>
                        </q-list>
                    </q-btn-dropdown>
                </template>
            </q-tabs>
            <q-space />
            <div class="q-pa-md q-gutter-sm">
                <q-chip
                    square
                    :style="{cursor: 'pointer'}">
                    {{ api.getUser()?.name }}
                    <q-popup-proxy :breakpoint="0">
                        <q-list class="bg-white text-black">
                            <q-item
                                v-close-popup
                                disabled
                                clickable>
                                <q-item-section>
                                    <q-item-label>сменить пароль</q-item-label>
                                </q-item-section>
                            </q-item>
                            <q-item
                                v-close-popup
                                clickable
                                @click="logout">
                                <q-item-section>
                                    <q-item-label>выйти</q-item-label>
                                </q-item-section>
                            </q-item>
                        </q-list>
                    </q-popup-proxy>
                </q-chip>
            </div>
        </q-toolbar>
    </q-header>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useQuasar } from "quasar";
import api from "@/api";
const $q = useQuasar();
const tab = ref("/");
const router = useRouter();
const menuRoutes = (() => {
    const arr = [];
    for (const i in router.options.routes) {
        if (!router.options.routes[i].meta?.label) continue;
        const route = {...router.options.routes[i]};
        route.index = `${i}`;
        for (const j in route.children) {
            if (!router.options.routes[i].meta?.label) continue;
            const subroute = route.children[j];
            subroute.path = [
                route.path,
                subroute.path
            ].join("/");
            subroute.index = `${i}-${j}`;
        }
        arr.push(route);
    }
    return arr;
})();
const logout = () => window.location.href = "/api/logout";
</script>
