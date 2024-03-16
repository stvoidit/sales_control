<template>
    <el-container>
        <el-header v-if="isNotLoginPage">
            <HeaderBase />
        </el-header>
        <el-main v-if="inited">
            <router-view v-slot="{ Component }">
                <component :is="Component" />
            </router-view>
        </el-main>
    </el-container>
</template>
<script setup>
import HeaderBase from "@/components/HeaderBase.vue";
import { ref } from "vue";
const inited = ref(false);
const isNotLoginPage = window.location.pathname !== "/login";
fetch("/api/init").then(response => {
    if (response.status === 401 && isNotLoginPage) window.location.href = "/login";
}).finally(() => inited.value = true);
</script>
