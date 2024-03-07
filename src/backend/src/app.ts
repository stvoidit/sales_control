import Fastify from "fastify";
import logger from "./logger.js";
import pluginDatabase from "./db/index.js";
import pluginRouter from "./routes/index.js";

const app = Fastify({ logger });
app.register(pluginDatabase);
app.register(pluginRouter, {
    staticDir: "/www/data/static"
});
const start = async () => {
    try {
        await app.listen({host: "0.0.0.0", port: 3000 });
    } catch (err) {
        logger.error(err);
        process.exit(1);
    }
};
const stop = async (signal) => await app.close();
start();
process.once("SIGINT", stop);
process.once("SIGTERM", stop);
