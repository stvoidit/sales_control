<template>
    <el-menu
        :default-active="activeIndex"
        router
        mode="horizontal">
        <template
            v-for="route in menuRoutes"
            :key="route.path">
            <el-menu-item
                v-if="!route.children"
                :index="route.path">
                {{ route.meta.label }}
            </el-menu-item>
            <el-sub-menu
                v-else
                :index="route.index">
                <template #title>
                    {{ route.meta.label }}
                </template>
                <el-menu-item
                    v-for="subroute in route.children"
                    :key="subroute.path"
                    :index="subroute.index"
                    :route="subroute">
                    {{ subroute.meta.label }}
                </el-menu-item>
            </el-sub-menu>
        </template>
    </el-menu>
</template>

<script setup>
import { ref, computed } from "vue";
import { useRouter } from "vue-router";
const activeIndex = ref("0");
const menuRoutes = computed(() => {
    const arr = [];
    const router = useRouter();
    for (const i in router.options.routes) {
        if (!router.options.routes[i].meta?.label) continue;
        const route = {...router.options.routes[i]};
        route.index = `${i}`;
        for (const j in route.children) {
            if (!router.options.routes[i].meta?.label) continue;
            const subroute = route.children[j];
            subroute.index = `${i}-${j}`;
        }
        arr.push(route);
    }
    return arr;
});

</script>

<style lang="scss" scoped>

</style>
