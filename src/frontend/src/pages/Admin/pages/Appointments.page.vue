<template>
    <el-dialog
        v-model="dialogFormVisible"
        destroy-on-close
        :show-close="false"
        width="800"
        @close="closeHandle">
        <pre>{{ form }}</pre>
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
    fetch("/api/users").then(response => response.json().then(data => users.value = data)),
    fetch("/api/salers").then(response => response.json().then(data => salers.value = data)),
    fetch("/api/retail_outlets").then(response => response.json().then(data => retailOutlets.value = data)),
    fetch("/api/appointments").then(response => response.json().then(data => appointments.value = data))
]);
onMounted(fetchData);

const onConfirm = async () => {
    const options = {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(form)
    };
    try {
        const response = await fetch("/api/appointments", options);
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

</script>
