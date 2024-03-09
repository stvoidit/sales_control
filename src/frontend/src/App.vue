<template>
    <el-container>
        <el-header v-if="isNotLoginPage">
            <HeaderBase />
        </el-header>
        <el-main>
            <router-view v-slot="{ Component }">
                <component :is="Component" />
            </router-view>
        </el-main>
    </el-container>
</template>
<script setup>
import HeaderBase from "@/pages/components/HeaderBase.vue";
const isNotLoginPage = window.location.pathname !== "/login";
fetch("/api/init").then(response => {
    if (response.status === 401 && isNotLoginPage) window.location.href = "/login";
});
</script>
