<template>
    <q-header
        bordered
        class="bg-white text-black"
        height-hint="98">
        <q-tabs
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
    </q-header>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
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
</script>
