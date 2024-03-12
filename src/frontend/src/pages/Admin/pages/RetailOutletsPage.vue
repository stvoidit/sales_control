<template>
    <el-dialog
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
                    :data="salers"
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
    </el-row>
</template>

<script setup>
import { onMounted, ref, reactive } from "vue";
const dialogFormVisible = ref(false);
const salers = ref([]);
const fetchData = async () => {
    const response = await await fetch("/api/retail_outlets");
    if (response.status === 401) {
        window.location.href = "/login";
        return;
    }
    salers.value = await response.json();
};
onMounted(fetchData);
const columns = [
    {
        prop: "id",
        label: "ID",
        width: 120
    },
    {
        prop: "label",
        label: "Название"
    },
    {
        prop: "address",
        label: "Адрес"
    },
    {
        prop: "created",
        label: "Дата создания",
        width: 300,
        formatter: (row) => new Date(row.created).toLocaleString()
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
    const options = {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(form)
    };
    try {
        const response = await fetch("/api/retail_outlets", options);
        if (response.status === 401) {
            window.location.href = "/login";
        }
        if (response.status === 201) {
            return await fetchData().then(() => dialogFormVisible.value = false);
        } else if (response.status < 500) {
            throw new Error(await response.text());
        } else alert(response.statusText);
    } catch (err) {
        alert(err);
    }
};

const handleDelete = async (id) => {
    const options = {
        method: "DELETE"
    };
    try {
        const response = await fetch(`/api/retail_outlets/${id}`, options);
        if (response.status === 401) {
            window.location.href = "/login";
        }
        if (response.status === 200) {
            return await fetchData().then(() => dialogFormVisible.value = false);
        } else if (response.status < 500) {
            throw new Error(await response.text());
        } else alert(response.statusText);
    } catch (err) {
        alert(err);
    }
};
</script>
