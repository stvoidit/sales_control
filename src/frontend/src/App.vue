<template>
    <q-layout view="hHh lpR fFf">
        <HeaderBase v-if="isNotLoginPage" />
        <q-page-container>
            <q-page
                v-if="inited"
                class="q-pt-md">
                <router-view v-slot="{ Component }">
                    <component :is="Component" />
                </router-view>
            </q-page>
        </q-page-container>
    </q-layout>
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
