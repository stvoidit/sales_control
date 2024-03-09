<template>
    <el-space
        wrap
        fill
        direction="vertical">
        <el-row class="row-max-width">
            <el-button
                plain
                @click="dialogFormVisible = true">
                Добавить нового продавца
            </el-button>
            <el-dialog
                v-model="dialogFormVisible"
                destroy-on-close
                :show-close="false"
                width="800">
                <el-form
                    :model="form"
                    label-width="auto">
                    <el-form-item
                        label="Название">
                        <el-input
                            v-model="form.label"
                            autocomplete="off" />
                    </el-form-item>
                    <el-form-item label="Описание или комментарий">
                        <el-input
                            v-model="form.description"
                            type="textarea" />
                    </el-form-item>
                </el-form>
                <template #footer>
                    <div class="dialog-footer">
                        <el-button @click="dialogFormVisible = false">
                            Cancel
                        </el-button>
                        <el-button
                            type="primary"
                            @click="dialogFormVisible = false">
                            Confirm
                        </el-button>
                    </div>
                </template>
            </el-dialog>
        </el-row>
        <el-row class="row-max-width">
            <el-table
                :data="salers"
                border
                table-layout="auto"
                size="small"
                style="width: 100%">
                <el-table-column
                    v-for="column in columns"
                    :key="column.id"
                    v-bind="column" />
            </el-table>
        </el-row>
    </el-space>
</template>

<script setup>
import { onMounted, ref, reactive } from "vue";
const dialogFormVisible = ref(false);
const salers = ref([]);
const fetchData = async () => fetch("/api/salers").then(response => response.json().then(data => salers.value = data));
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
        prop: "description",
        label: "Описание или комментарий"
    },
    {
        prop: "created",
        label: "Дата создания",
        width: 300,
        formatter: (row) => {
            return new Date(row.created).toLocaleString();
        }
    }
];
const form = reactive({
    label: "",
    description: ""
});
</script>
