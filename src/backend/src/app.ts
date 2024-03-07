import {routes, statisRoute} from "./routes/index.js";

import Fastify from "fastify";
import {pino} from "pino";
import {build as pretty} from "pino-pretty";

const logger = pino(pretty({ colorize: true, singleLine: true }));
const app = Fastify({logger:logger});
app.register(routes);
if (process.env.NODE_ENV !== "development") {
    app.register(statisRoute, {
        staticDir: "/www/data/static"
    });

}

const start = async () => {
    try {
        await app.listen({ port: 3000 });
    } catch (err) {
        app.log.error(err);
        process.exit(1);
    }
};
start();
