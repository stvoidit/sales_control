<template>
    <div class="q-pa-md">
        <q-table
            :rows="data"
            :grid="false"
            hide-pagination
            dense
            :columns="columns"
            row-key="id" />
    </div>
</template>

<script setup>
import { toLocalDateString } from "@/utils";
defineProps({
    data: { type: Array, required: true}
});
const columns = [
    {
        label: "Дата отчета",
        field: "report_date",
        align: "left",
        format: (value) => toLocalDateString(value)
    },
    {
        label: "Дата отправки отчета",
        field: "created",
        align: "left",
        format: (value) => new Date(value).toLocaleString()
    },
    {
        label: "Пользователь",
        field: "login",
        align: "left"
    },
    {
        label: "Продавец",
        field: "saler",
        align: "left"
    },
    {
        label: "Торговая точка",
        field: "retail_outlet",
        align: "left"
    },
    {
        label: "Вал",
        field: "val",
        align: "left",
        format: (value) => value.toLocaleString()
    },
    {
        label: "Бл",
        field: "bl",
        align: "left",
        format: (value) => value.toLocaleString()
    },
    {
        label: "Нал",
        field: "nal",
        align: "left",
        format: (value) => value.toLocaleString()
    }
];

</script>
