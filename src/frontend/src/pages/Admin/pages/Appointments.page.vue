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
                label="Пользователь"
                required>
                <el-select
                    v-model="form.user">
                    <el-option
                        v-for="item in users"
                        :key="item.login"
                        :label="item.login"
                        :value="item" />
                </el-select>
            </el-form-item>
            <el-form-item
                label="Продавец"
                required>
                <el-select
                    v-model="form.saler">
                    <el-option
                        v-for="item in salers"
                        :key="item.label"
                        :label="item.label"
                        :value="item" />
                </el-select>
            </el-form-item>
            <el-form-item
                label="Торговая точка"
                required>
                <el-select
                    v-model="form.retail_outlet">
                    <el-option
                        v-for="item in retailOutlets"
                        :key="item.label"
                        :label="item.label"
                        :value="item" />
                </el-select>
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
    <el-row>
        <el-col :span="24">
            <el-button
                plain
                @click="dialogFormVisible = true">
                Добавить связь
            </el-button>
        </el-col>
        <el-col :span="24" />
    </el-row>
    <el-space wrap>
        <el-card
            v-for="ap in appointments"
            :key="ap.id"
            style="min-width: 320px">
            <el-row>
                <el-col>
                    <div><b>Пользователь: </b>{{ ap.user.login }}</div>
                    <div><b>Продавец: </b>{{ ap.saler.label }}</div>
                    <div><b>Торговая точка: </b>{{ ap.retail_outlet.label }}</div>
                    <div><b>Адрес: </b>{{ ap.retail_outlet.address }}</div>
                </el-col>
            </el-row>
            <el-row justify="end">
                <el-button
                    size="small"
                    type="danger">
                    delete
                </el-button>
            </el-row>
        </el-card>
    </el-space>
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

const fetchData = async () => await Promise.all([
    api.getUsers().then(data => users.value = data),
    api.getSalers().then(data => salers.value = data),
    api.getRetailOutlets().then(data => retailOutlets.value = data),
    api.getAppointments().then(data => appointments.value = data)
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

</script>
