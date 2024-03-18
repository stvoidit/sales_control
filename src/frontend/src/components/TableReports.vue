<template>
    <div class="q-pa-md">
        <q-table
            :rows="data"
            :grid="false"
            hide-pagination
            bordered
            :columns="columns"
            row-key="id" />
    </div>
</template>

<script setup>
import dayjs from "dayjs";
defineProps({
    data: { type: Array, required: true}
});
const columns = [
    {
        label: "Дата отчета",
        field: "report_date",
        format: (value) => dayjs(value).format("DD.MM.YYYY")
    },
    {
        label: "Дата отправки отчета",
        field: "created",
        format: (value) => new Date(value).toLocaleString()
    },
    {
        label: "Пользователь",
        field: "login"
    },
    {
        label: "Продавец",
        field: "saler"
    },
    {
        label: "Торговая точка",
        field: "retail_outlet"
    },
    {
        label: "Вал",
        field: "val",
        format: (value) => value.toLocaleString()
    },
    {
        label: "Бл",
        field: "bl",
        format: (value) => value.toLocaleString()
    },
    {
        label: "Нал",
        field: "nal",
        format: (value) => value.toLocaleString()
    }
];

</script>
