<template>
    <el-row justify="center">
        <el-col :span="12">
            <ReportForm
                :report-options="reportOptions"
                @submit="fetchReportOption" />
        </el-col>
    </el-row>

    <el-row style="margin-top: 2em;">
        <el-col>
            <el-card>
                <el-table
                    :data="reportsLog"
                    border
                    flexible
                    size="small"
                    style="width: 100%">
                    <el-table-column
                        v-for="column in columns"
                        :key="column.id"
                        v-bind="column" />
                </el-table>
            </el-card>
        </el-col>
    </el-row>
</template>

<script setup>
import { onMounted, ref } from "vue";
import ReportForm from "@/pages/components/ReportForm.vue";
import dayjs from "dayjs";
import api from "@/api";
const reportsLog = ref([]);
const reportOptions = ref([]);
const fetchReportOption = async () => await Promise.all([
    api.getReportOption().then(data => reportOptions.value = data),
    api.getReportsLog().then(data => reportsLog.value = data)
]);
onMounted(fetchReportOption);
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
