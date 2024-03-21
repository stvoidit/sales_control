<template>
    <div class="row q-mt-md q-gutter-md justify-center">
        <div :class="$q.screen.lt.md ? 'col' : 'col-6'">
            <q-table
                class="q-mt-md"
                :rows="prices"
                :grid="$q.screen.lt.md"
                hide-pagination
                dense
                row-key="id" />
        </div>
    </div>
</template>

<script setup>
import { onMounted, shallowRef } from "vue";
import api from "@/api";
import { useQuasar } from "quasar";
const $q = useQuasar();
const prices = shallowRef([]);
const fetchData = async () => await api.getActualPrices().then(data => prices.value = data);
onMounted(fetchData);
</script>
