<template>
    <div
        class="column"
        style="height: 500px">
        <div class="col self-center">
            <q-card style="max-width: 480px">
                <q-card-section>
                    <q-form
                        class="q-gutter-md"
                        @submit="onSubmit"
                        @keypress.enter="onSubmit">
                        <q-input
                            v-model="form.login"
                            outlined
                            dense
                            autocomplete="on"
                            label="Логин" />
                        <q-input
                            v-model="form.password"
                            outlined
                            dense
                            type="password"
                            autocomplete="off"
                            label="Пароль" />
                        <div class="row justify-end q-gutter-md">
                            <q-btn
                                label="login"
                                type="submit"
                                color="primary" />
                        </div>
                    </q-form>
                </q-card-section>
            </q-card>
        </div>
    </div>
</template>

<script setup>
import { reactive } from "vue";
const form = reactive({
    login: "",
    password: ""
});
const onSubmit = async () => {
    const options = {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify(form)
    };
    return await fetch("/api/login", options).then(response => {
        if (response.status === 200) {
            window.location.href = "/";
        }
    });
};
</script>
