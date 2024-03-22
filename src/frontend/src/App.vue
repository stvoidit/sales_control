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
import api from "@/api";
const inited = ref(false);
const isNotLoginPage = window.location.pathname !== "/login";
api.init().finally(() => inited.value = true);
</script>
