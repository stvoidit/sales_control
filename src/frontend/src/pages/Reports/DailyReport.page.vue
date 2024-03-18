<template>
    <div class="row justify-center">
        <ReportForm
            :report-options="reportOptions"
            @submit="fetchReportOption" />
    </div>
    <div class="row q-mt-md">
        <div class="col">
            <TableReports :data="reportsLog" />
        </div>
    </div>
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
