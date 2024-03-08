import "dayjs/locale/ru";

import App from "./App.vue";
import ElementPlus from "element-plus";
import { createApp } from "vue";
import router from "./router.js";
import ruLang from "element-plus/es/locale/lang/ru";
const app = createApp(App);
app.use(router);
app.use(ElementPlus, { locale: ruLang });
app.mount("#app");
