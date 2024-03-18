<template>
    <!-- <el-dialog
        v-model="dialogFormVisible"
        destroy-on-close
        :show-close="false"
        width="800"
        @close="closeHandle">
        <el-form
            :model="form"
            label-width="auto">
            <el-form-item
                label="Название"
                required>
                <el-input
                    v-model="form.label"
                    autocomplete="off" />
            </el-form-item>
            <el-form-item label="Адрес">
                <el-input
                    v-model="form.address"
                    type="textarea" />
            </el-form-item>
        </el-form>
        <template #footer>
            <div class="dialog-footer">
                <el-button @click="dialogFormVisible = false">
                    Закрыть
                </el-button>
                <el-button
                    type="primary"
                    @click="onConfirm">
                    Подтвердить
                </el-button>
            </div>
        </template>
    </el-dialog>
    <el-row :gutter="20">
        <el-space
            wrap
            fill>
            <el-col :span="24">
                <el-button
                    plain
                    @click="dialogFormVisible = true">
                    Добавить новую точку
                </el-button>
            </el-col>
            <el-col :span="24">
                <el-table
                    :data="retailOutlets"
                    border
                    flexible
                    size="small"
                    style="width: 100%">
                    <el-table-column
                        v-for="column in columns"
                        :key="column.id"
                        v-bind="column" />
                    <el-table-column
                        fixed="right"
                        label="Operations"
                        width="180">
                        <template #default="{row}">
                            <el-button
                                type="primary"
                                size="small">
                                Edit
                            </el-button>
                            <el-button
                                type="danger"
                                size="small"
                                @click="handleDelete(row.id)">
                                Delete
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-space>
    </el-row> -->
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
                label="Добавить новую торговую точку"
                @click="dialogFormVisible = true" />
            <q-table
                class="q-mt-md"
                :rows="retailOutlets"
                :grid="false"
                hide-pagination
                bordered
                :columns="columns"
                row-key="id" />
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
        label: "ID",
        width: 120
    },
    {
        field: "label",
        label: "Название"
    },
    {
        field: "address",
        label: "Адрес"
    },
    {
        field: "created",
        label: "Дата создания",
        width: 300,
        format: (value) => new Date(value).toLocaleString()
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
