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
                    <q-input
                        v-model="form.label"
                        outlined
                        autocomplete="off"
                        label="Название" />
                    <q-input
                        v-model="form.address"
                        outlined
                        autocomplete="off"
                        label="Адрес" />
                    <div class="row justify-end q-gutter-md">
                        <q-btn
                            label="Закрыть"
                            class="q-ml-sm"
                            @click="dialogFormVisible = false" />
                        <q-btn
                            label="Добавить"
                            type="submit"
                            color="primary" />
                    </div>
                </q-form>
            </q-card-section>
        </q-card>
    </q-dialog>
    <div class="row q-col-gutter-md q-pa-md">
        <div class="col">
            <q-btn
                label="Добавить новую торговую точку"
                @click="dialogFormVisible = true" />
            <q-table
                class="q-mt-md"
                :rows="retailOutlets"
                :grid="false"
                hide-pagination
                bordered
                :columns="columns"
                row-key="id">
                <template #header="props">
                    <q-tr :props="props">
                        <q-th
                            v-for="col in props.cols"
                            :key="col.name"
                            :props="props">
                            {{ col.label }}
                        </q-th>
                    </q-tr>
                </template>
                <template #body="props">
                    <q-tr :props="props">
                        <q-td
                            v-for="col in props.cols"
                            :key="col.name">
                            <template v-if="col.name !== 'btns'">
                                {{ col.value }}
                            </template>
                            <q-btn
                                v-else
                                dense
                                color="negative"
                                label="удалить"
                                @click="handleDelete(props.row.id)" />
                        </q-td>
                    </q-tr>
                </template>
            </q-table>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, reactive } from "vue";
import api from "@/api";
const dialogFormVisible = ref(false);
const retailOutlets = ref([]);
const fetchData = async () => api.getRetailOutlets().then(data => retailOutlets.value = data);
onMounted(fetchData);
const columns = [
    {
        field: "id",
        name: "id",
        align: "left",
        label: "ID"
    },
    {
        field: "label",
        name: "label",
        align: "left",
        label: "Название"
    },
    {
        field: "address",
        name: "address",
        align: "left",
        label: "Адрес"
    },
    {
        field: "created",
        label: "Дата создания",
        name: "icreatedd",
        align: "left",
        format: (value) => new Date(value).toLocaleString()
    },
    {
        name: "btns",
        label: "Действия",
        align: "left",
        field: row => row.name
    }
];
const form = reactive({
    label: "",
    address: ""
});
const closeHandle = () => {
    form.label = "";
    form.description = "";
};

const onConfirm = async () => {
    try {
        await api.createRetailOutlet(form);
        return fetchData().then(() => dialogFormVisible.value = false);
    } catch (err) {
        alert(err);
    }
};

// TODO: вернуть функционал в таблице, добавить столбец с кнопками
const handleDelete = async (id) => {
    try {
        await api.deleteRetailOutlet(id).then(fetchData);
    } catch (err) {
        alert(err);
    }
};
</script>
