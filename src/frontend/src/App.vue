<template>
    <el-container>
        <el-header>
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
</script>
<style>
.row-max-width {
    width: 100vw
}
</style>
