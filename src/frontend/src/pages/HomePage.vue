<template>
    <div class="row q-mt-md q-gutter-md justify-center">
        <div class="col-4">
            <q-table
                class="q-mt-md"
                :rows="prices"
                :grid="false"
                hide-pagination
                dense
                row-key="id" />
        </div>
    </div>
</template>

<script setup>
import { onMounted, shallowRef } from "vue";
import api from "@/api";
const prices = shallowRef([]);
const fetchData = async () => await api.getActualPrices().then(data => prices.value = data);
onMounted(fetchData);
</script>
