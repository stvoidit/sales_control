import "dayjs/locale/ru";
import "quasar/src/css/index.sass";
import "@quasar/extras/material-icons/material-icons.css";

import { Notify, Quasar } from "quasar";

import App from "./App.vue";
import { createApp } from "vue";
import router from "./router.js";
const app = createApp(App);
app.use(router);
app.use(Quasar, {
    plugins: {
        Notify
    },
    config: {
        notify: {
            position: "top-right"
        }
    }
});
app.mount("#app");
