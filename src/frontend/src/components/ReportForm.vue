<template>
    <q-card>
        <q-card-section class="q-gutter-md">
            <q-form
                class="q-gutter-md"
                @submit="handleSendReport"
                @reset="handleResetForm">
                <div class="row q-col-gutter-md q-mb-md">
                    <div class="col-3">
                        <q-input
                            v-model="form.report_date"
                            outlined
                            dense>
                            <template #append>
                                <q-icon
                                    name="event"
                                    class="cursor-pointer">
                                    <q-popup-proxy
                                        ref="calendarPopup"
                                        cover
                                        transition-show="scale"
                                        transition-hide="scale">
                                        <q-date
                                            v-model="form.report_date"
                                            v-close-popup
                                            dense
                                            title="Дата отчета"
                                            mask="DD.MM.YYYY"
                                            minimal />
                                    </q-popup-proxy>
                                </q-icon>
                            </template>
                        </q-input>
                    </div>
                    <div class="col">
                        <q-select
                            v-model="form.saler_id"
                            label="Продавец"
                            outlined
                            dense
                            :options="reportOptions"
                            option-value="id"
                            option-label="label"
                            emit-value
                            map-options
                            @update:model-value="resetRetailOutletID" />
                    </div>
                    <div class="col">
                        <q-select
                            v-model="form.retail_outlet_id"
                            label="Торговая точка"
                            outlined
                            dense
                            :disable="!availibleOutlets.length"
                            :options="availibleOutlets"
                            option-value="id"
                            option-label="label"
                            emit-value
                            map-options />
                    </div>
                </div>
                <div class="row q-col-gutter-md">
                    <div class="col-4">
                        <q-input
                            v-model.number="form.report.val"
                            outlined
                            dense
                            label="Вал"
                            @change="(value) => form.report.val = toFixedFloat(value)" />
                    </div>
                    <div class="col-4">
                        <q-input
                            v-model.number="form.report.bl"
                            outlined
                            dense
                            label="Бл"
                            @change="(value) => form.report.bl = toFixedFloat(value)" />
                    </div>
                    <div class="col-4">
                        <q-input
                            v-model.number="form.report.nal"
                            outlined
                            dense
                            label="Нал"
                            @change="(value) => form.report.nal = toFixedFloat(value)" />
                    </div>
                </div>
                <div class="row justify-end q-gutter-md">
                    <q-btn
                        dense
                        label="Сбросить"
                        type="reset" />
                    <q-btn
                        dense
                        label="Подтвердить"
                        type="submit"
                        color="primary" />
                </div>
            </q-form>
        </q-card-section>
    </q-card>
</template>

<script setup>
import { reactive, computed } from "vue";
import { useQuasar } from "quasar";
import api from "@/api";
import { toValidDateString, toLocalDateString } from "@/utils";
const $q = useQuasar();
const props = defineProps({
    reportOptions: { type: Array, required: true }
});
const emit = defineEmits(["submit"]);
const today = toLocalDateString(Date.now());
const form = reactive({
    saler_id: null,
    retail_outlet_id: null,
    report_date: today,
    report: {
        val: 0.0,
        bl: 0.0,
        nal: 0.0
    }
});

const toFixedFloat = (value) => parseFloat(parseFloat(value).toFixed(2));

// const validateNal = (rule, value, callback) => {
//     if ((form.report.val + form.report.bl) != value) {
//         callback(new Error("nal != val+bl"));
//     } else {
//         callback();
//     }
// };
// const validateNotNull = (rule, value, callback) => {
//     if (!form[rule.field]) {
//         callback(new Error(`${rule.field} is null`));
//     } else {
//         callback();
//     }
// };
// const validateRules = reactive({
//     "report.nal": [{ trigger: "blur", validator: validateNal }],
//     "saler_id": [{ trigger: "blur", validator: validateNotNull }],
//     "retail_outlet_id": [{ trigger: "blur", validator: validateNotNull }],
//     "report_date": [{ trigger: "blur", validator: validateNotNull }]
// });
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
};
const handleSendReport = async () => {
    const copyForm = { ...form, report: { ...form.report } };
    copyForm.report_date = toValidDateString(copyForm.report_date);
    try {
        await api.sendReport(copyForm).then(handleResetForm);
        $q.notify({
            color: "green-4",
            textColor: "white",
            icon: "cloud_done",
            message: "Отчет отправлен"
        });
        emit("submit");
    } catch (error) {
        alert(error);
    }

};
const resetRetailOutletID = () => form.retail_outlet_id = null;
// const disabledDate = (date) => today.isBefore(dayjs(date).startOf("day"));
</script>
