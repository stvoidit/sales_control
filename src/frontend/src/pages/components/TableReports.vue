<template>
    <el-table
        :data="data"
        border
        flexible
        size="small"
        style="width: 100%">
        <el-table-column
            v-for="column in columns"
            :key="column.id"
            v-bind="column" />
    </el-table>
</template>

<script setup>
import dayjs from "dayjs";
defineProps({
    data: { type: Array, required: true}
});
const columns = [
    {
        label: "Дата отчета",
        prop: "report_date",
        formatter: (row) => dayjs(row.report_date).format("DD.MM.YYYY")
    },
    {
        label: "Дата отправки отчета",
        prop: "created",
        formatter: (row) => new Date(row.created).toLocaleString()
    },
    {
        label: "Пользователь",
        prop: "login"
    },
    {
        label: "Продавец",
        prop: "saler"
    },
    {
        label: "Торговая точка",
        prop: "retail_outlet"
    },
    {
        label: "Вал",
        prop: "val",
        formatter: (row) => row.val.toLocaleString()
    },
    {
        label: "Бл",
        prop: "bl",
        formatter: (row) => row.bl.toLocaleString()
    },
    {
        label: "Нал",
        prop: "nal",
        formatter: (row) => row.nal.toLocaleString()
    }
];

</script>
