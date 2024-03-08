<template>
    <el-container>
        <!-- <el-header v-if="isAuth">
        <HeaderApp />
    </el-header> -->
        <el-main>
            <router-view v-slot="{ Component }">
                <component :is="Component" />
            </router-view>
        </el-main>
    </el-container>
</template>
<script setup>
// import HeaderApp from "@/components/HeaderApp.vue";
// fetch("/api/users").then((response) => {
//     if (response.status === 401) {
//         window.location.href = "/login";
//     }
// }).catch(err => console.error("/api/init:", err));

</script>
x
