<template>
    <q-dialog
        v-model="dialogFormVisible"
        :auto-close="false"
        @before-hide="closeHandle">
        <q-card>
            <q-card-section>
                <q-form
                    class="q-gutter-md"
                    @submit="onConfirm">
                    <q-select
                        v-model="form.user"
                        outlined
                        dense
                        :options="users"
                        label="Пользователь"
                        option-label="login"
                        emit-value />
                    <q-select
                        v-model="form.saler"
                        outlined
                        dense
                        :options="salers"
                        label="Продавец" />
                    <q-select
                        v-model="form.retail_outlet"
                        outlined
                        dense
                        :options="retailOutlets"
                        label="Торговая точка" />
                    <div class="row justify-end q-gutter-md">
                        <q-btn
                            label="Закрыть"
                            class="q-ml-sm"
                            @click="dialogFormVisible = false" />
                        <q-btn
                            label="Добавить"
                            type="submit"
                            color="primary"
                            @click="onConfirm" />
                    </div>
                </q-form>
            </q-card-section>
        </q-card>
    </q-dialog>
    <div class="row q-col-gutter-md q-pa-md">
        <div class="col">
            <q-btn
                label="Добавить связь"
                @click="dialogFormVisible = true" />
            <q-table
                class="q-mt-md"
                :rows="appointments"
                :grid="true"
                hide-pagination
                bordered
                :columns="columns"
                row-key="id" />
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import api from "@/api";
const dialogFormVisible = ref(false);
const form = reactive({
    id: null,
    user: null,
    saler: null,
    retail_outlet: null
});
const closeHandle = () => {
    form.id = null;
    form.user = null;
    form.saler = null;
    form.retail_outlet = null;
};

const users = ref([]);
const salers = ref([]);
const retailOutlets = ref([]);
const appointments = ref([]);

const appointmentsMap = (v) => ({
    "user.login": v.user.login,
    "saler.label": v.saler.label,
    "retail_outlet.label": v.retail_outlet.label,
    "retail_outlet.address": v.retail_outlet.address
});
const fetchData = async () => await Promise.all([
    api.getUsers().then(data => users.value = data),
    api.getSalers().then(data => salers.value = data),
    api.getRetailOutlets().then(data => retailOutlets.value = data),
    api.getAppointments().then(data => appointments.value = data.map(appointmentsMap))
]);
onMounted(fetchData);

const onConfirm = async () => {
    try {
        await api.createAppointments(form).then();
        return await fetchData().then(() => dialogFormVisible.value = false);
    } catch (err) {
        alert(err);
    }
};

const columns = [
    {
        field: "user.login",
        label: "Пользователь"
    },
    {
        field: "saler.label",
        label: "Продавец"
    },
    {
        field: "retail_outlet.label",
        label: "Торговая точка"
    },
    {
        field: "retail_outlet.address",
        label: "Адрес"
    }
];

// TODO: вернуть функционал в таблице, добавить столбец с кнопками

</script>
