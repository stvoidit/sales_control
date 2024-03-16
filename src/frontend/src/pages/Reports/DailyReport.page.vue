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
            <TableReports :data="reportsLog" />
        </el-col>
    </el-row>
</template>

<script setup>
import { onMounted, ref } from "vue";
import ReportForm from "@/components/ReportForm.vue";
import TableReports from "@/components/TableReports.vue";
import api from "@/api";
const reportsLog = ref([]);
const reportOptions = ref([]);
const fetchReportOption = async () => await Promise.all([
    api.getReportOption().then(data => reportOptions.value = data),
    api.getReportsLog().then(data => reportsLog.value = data)
]);
onMounted(fetchReportOption);
</script>
