<template>
    <el-row justify="center">
        <el-col :span="12">
            <el-card>
                <el-form
                    :model="form"
                    label-position="top"
                    label-width="auto">
                    <el-form-item
                        label="Дата отчета"
                        required>
                        <el-date-picker
                            v-model="form.report_date"
                            :disabled-date="disabledDate"
                            format="DD.MM.YYYY"
                            type="date" />
                    </el-form-item>
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <el-form-item
                                label="Продавец"
                                required>
                                <el-select
                                    v-model="form.saler_id"
                                    @change="resetRetailOutletID">
                                    <el-option
                                        v-for="item in reportOptions"
                                        :key="item.id"
                                        :label="item.label"
                                        :value="item.id" />
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item
                                label="Торговая точка"
                                required>
                                <el-select
                                    v-model="form.retail_outlet_id">
                                    <el-option
                                        v-for="item in availibleOutlets"
                                        :key="item.id"
                                        :label="item.label"
                                        :value="item.id" />
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row :gutter="20">
                        <el-col :span="8">
                            <el-form-item
                                label="Вал"
                                required>
                                <el-input-number
                                    v-model="form.report.val"
                                    style="width: 80%;"
                                    :controls="false"
                                    :precision="2"
                                    type="number" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item
                                label="Бл"
                                required>
                                <el-input-number
                                    v-model="form.report.bl"
                                    style="width: 80%;"
                                    :controls="false"
                                    :precision="2"
                                    type="number" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item
                                label="Нал"
                                required>
                                <el-input-number
                                    v-model="form.report.nal"
                                    style="width: 80%;"
                                    :controls="false"
                                    :precision="2"
                                    type="number" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
                <template #footer>
                    <el-row justify="end">
                        <el-button @click="handleResetForm">
                            Сбросить
                        </el-button>
                        <el-button
                            type="success"
                            @click="handleSendReport">
                            Подтвердить
                        </el-button>
                    </el-row>
                </template>
            </el-card>
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
import { onMounted, ref, reactive, computed } from "vue";
import { ElNotification } from "element-plus";
import dayjs from "dayjs";
import api from "@/api";
import "element-plus/es/components/notification/style/css";
const form = reactive({
    saler_id: null,
    retail_outlet_id: null,
    report_date: new Date(),
    report: {
        val: 0,
        bl: 0,
        nal: 0
    }
});

const reportOptions = ref([]);
const reportsLog = ref([]);
const availibleOutlets = computed(() => {
    const selectedSaler = reportOptions.value.find(opt => opt.id === form.saler_id);
    if (selectedSaler) {
        return selectedSaler.retail_outlets;
    } else {
        return [];
    }
});
const fetchReportOption = async () => await Promise.all([
    api.getReportOption().then(data => reportOptions.value = data),
    api.getReportsLog().then(data => reportsLog.value = data)
]);
onMounted(fetchReportOption);
const resetRetailOutletID = () => form.retail_outlet_id = null;
const today = dayjs().startOf("day");
const disabledDate = (date) => today.isBefore(dayjs(date).startOf("day"));

const handleResetForm = () => {
    form.saler_id = null;
    form.retail_outlet_id = null;
    form.report.val = 0;
    form.report.bl = 0;
    form.report.nal = 0;
};
const handleSendReport = async () => {
    try {
        await api.sendReport(form).then(handleResetForm);
        ElNotification({
            title: "Отправка отчета",
            message: "Отчет отправлен",
            type: "success",
            showClose: false,
            duration: 2500
        });
        return await fetchReportOption();
    } catch (error) {
        alert(error);
    }
};

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
