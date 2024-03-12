<template>
    <div>
        <pre> {{ users }}</pre>
    </div>
</template>

<script setup>
import { onMounted, shallowRef } from "vue";
import api from "@/api";
const users = shallowRef([]);
const fetchData = async () => api.getUsers().then(data => users.value = data);
onMounted(fetchData);
</script>
