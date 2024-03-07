import {routes, statisRoute} from "./routes/index.js";

import Fastify from "fastify";
import {closeDatabaseConnection} from "./db/index.js";
import logger from "./logger.js";

const app = Fastify({logger});
app.register(routes);
if (process.env.NODE_ENV !== "development") {
    app.register(statisRoute, {
        staticDir: "/www/data/static"
    });
}

const start = async () => {
    try {
        await app.listen({host: "0.0.0.0", port: 3000 });
    } catch (err) {
        app.log.error(err);
        process.exit(1);
    }
};
const stop = async (signal) => {
    await closeDatabaseConnection();
    await app.close();
};
start();
process.once("SIGINT", stop);
process.once("SIGTERM", stop);
