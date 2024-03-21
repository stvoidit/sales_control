import "quasar/src/css/index.sass";
import "@quasar/extras/material-icons/material-icons.css";

import { Notify, Quasar } from "quasar";

import App from "./App.vue";
import { createApp } from "vue";
import langRu from "quasar/lang/ru";
import router from "./router.js";

const app = createApp(App);
app.use(router);
app.use(Quasar, {
    lang: langRu,
    plugins: {
        Notify
    },
    config: {
        notify: {
            position: "top-right"
        },
        screen: {
            bodyClasses: true
        }
    }
});
app.mount("#app");
