<template>
    <div :class="$q.screen.lt.md ? 'col-6': 'col-auto'">
        <q-input
            v-model="filters.dateFrom"
            class="q-pa-md"
            label="дата с:"
            outlined
            dense>
            <template #append>
                <q-icon
                    name="event"
                    class="cursor-pointer">
                    <q-popup-proxy
                        cover
                        transition-show="scale"
                        transition-hide="scale">
                        <q-date
                            v-model="filters.dateFrom"
                            dense
                            :options="optionDateFrom"
                            title="Дата отчета"
                            mask="DD.MM.YYYY">
                            <div class="row items-center justify-end q-gutter-sm">
                                <q-btn
                                    v-close-popup
                                    dense
                                    label="сбросить"
                                    color="primary"
                                    flat
                                    @click="() => filters.dateFrom = null" />
                            </div>
                        </q-date>
                    </q-popup-proxy>
                </q-icon>
            </template>
        </q-input>
    </div>
    <div :class="$q.screen.lt.md ? 'col-6': 'col-auto'">
        <q-input
            v-model="filters.dateTo"
            class="q-pa-md"
            label="дата по:"
            outlined
            dense>
            <template #append>
                <q-icon
                    name="event"
                    class="cursor-pointer">
                    <q-popup-proxy
                        cover
                        transition-show="scale"
                        transition-hide="scale">
                        <q-date
                            v-model="filters.dateTo"
                            dense
                            :options="optionDateTo"
                            title="Дата отчета"
                            mask="DD.MM.YYYY">
                            <div class="row items-center justify-end q-gutter-sm">
                                <q-btn
                                    v-close-popup
                                    dense
                                    label="сбросить"
                                    color="primary"
                                    flat
                                    @click="() => filters.dateTo = null" />
                            </div>
                        </q-date>
                    </q-popup-proxy>
                </q-icon>
            </template>
        </q-input>
    </div>
</template>

<script setup>
import { reactive, watch } from "vue";
import { toValidDateString, extractDate } from "@/utils";
import { useQuasar } from "quasar";
const $q = useQuasar();
const filters = reactive({
    dateFrom: null,
    dateTo: null
});
const emit = defineEmits(["change:filters"]);
watch(
    filters,
    (cur) => emit("change:filters", {
        dateFrom: filters.dateFrom ? toValidDateString(filters.dateFrom) : null,
        dateTo: filters.dateTo ? toValidDateString(filters.dateTo ) : null
    })
);


const optionDateFrom = (date) => {
    if (filters.dateTo) {
        return extractDate(date, "YYYY/MM/DD") <= extractDate(filters.dateTo, "DD.MM.YYYY");
    }
    return true;
};
const optionDateTo = (date) => {
    if (filters.dateTo) {
        return extractDate(date, "YYYY/MM/DD") >= extractDate(filters.dateFrom, "DD.MM.YYYY");
    }
    return true;
};
</script>
