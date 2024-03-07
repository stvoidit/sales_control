import Fastify from "fastify";
import db from "./db/index.js";
import logger from "./logger.js";
import router from "./routes/index.js";

const app = Fastify({ logger });
app.register(db);
app.register(router, {
    staticDir: "/www/data/static"
});
const start = async () => {
    try {
        await app.listen({host: "0.0.0.0", port: 3000 });
    } catch (err) {
        app.log.error(err);
        process.exit(1);
    }
};
const stop = async (signal) => {
    await app.db.end();
    await app.close();
};
start();
process.once("SIGINT", stop);
process.once("SIGTERM", stop);
