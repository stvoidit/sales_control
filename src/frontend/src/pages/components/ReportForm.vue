<template>
    <el-card>
        <el-form
            ref="formElement"
            :model="form"
            status-icon
            :rules="validateRules"
            label-position="top"
            label-width="auto">
            <el-form-item
                label="Дата отчета"
                prop="report_date"
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
                        prop="saler_id"
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
                        prop="retail_outlet_id"
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
                        prop="report.nal"
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
</template>

<script setup>
import { reactive, computed, ref } from "vue";
import api from "@/api";
import dayjs from "dayjs";
import { ElNotification } from "element-plus";
import "element-plus/es/components/notification/style/css";
const props = defineProps({
    reportOptions: { type: Array, required: true }
});
const emit = defineEmits(["submit"]);
const today = dayjs().startOf("day");
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
const formElement = ref();
const validateNal = (rule, value, callback) => {
    if ((form.report.val + form.report.bl) != value) {
        callback(new Error("nal != val+bl"));
    } else {
        callback();
    }
};
const validateNotNull = (rule, value, callback) => {
    if (!form[rule.field]) {
        callback(new Error(`${rule.field} is null`));
    } else {
        callback();
    }
};
const validateRules = reactive({
    "report.nal": [{ trigger: "blur", validator: validateNal }],
    "saler_id": [{ trigger: "blur", validator: validateNotNull }],
    "retail_outlet_id": [{ trigger: "blur", validator: validateNotNull }],
    "report_date": [{ trigger: "blur", validator: validateNotNull }]
});
const availibleOutlets = computed(() => {
    const selectedSaler = props.reportOptions.find(opt => opt.id === form.saler_id);
    if (selectedSaler) {
        return selectedSaler.retail_outlets;
    } else {
        return [];
    }
});
const handleResetForm = () => {
    form.saler_id = null;
    form.retail_outlet_id = null;
    form.report.val = 0;
    form.report.bl = 0;
    form.report.nal = 0;
    formElement.value.resetFields();
};
const handleSendReport = async () => {
    if (!formElement.value) return;
    if (await formElement.value.validate(valid => valid)) {
        try {
            await api.sendReport(form).then(handleResetForm);
            ElNotification({
                title: "Отправка отчета",
                message: "Отчет отправлен",
                type: "success",
                showClose: false,
                duration: 2500
            });
            emit("submit");
        } catch (error) {
            alert(error);
        }
    }
};
const resetRetailOutletID = () => form.retail_outlet_id = null;
const disabledDate = (date) => today.isBefore(dayjs(date).startOf("day"));
</script>
