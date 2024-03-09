<template>
    <el-row
        justify="center"
        align="middle">
        <el-col :span="6">
            <el-card style="max-width: 480px">
                <el-form
                    id="login-form"
                    v-model="loginForm"
                    label-width="auto">
                    <el-form-item
                        label="login"
                        required>
                        <el-input
                            v-model="loginForm.login"
                            name="login"
                            form="login-form" />
                    </el-form-item>
                    <el-form-item
                        label="password"
                        required>
                        <el-input
                            v-model="loginForm.password"
                            form="login-form"
                            name="password"
                            type="password"
                            autocomplete="off" />
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            form="login-form"
                            type="primary"
                            @click="onSubmit">
                            login
                        </el-button>
                    </el-form-item>
                </el-form>
            </el-card>
        </el-col>
    </el-row>
</template>

<script setup>
import { reactive } from "vue";
const loginForm = reactive({
    login: "",
    password: ""
});
const onSubmit = async () => {
    const options = {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(loginForm)
    };
    return await fetch("/api/login", options).then(response => {
        if (response.status === 200) {
            window.location.href = "/";
        }
    });
};
</script>
