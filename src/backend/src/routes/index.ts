import { FastifyInstance } from "fastify";
import fastifyPlugin from "fastify-plugin";
import routes from "./endpoints.js";
import statisRoute from "./statis.js";

export default fastifyPlugin(function (instance: FastifyInstance, opts: any, done) {
    if (process.env.NODE_ENV !== "development") {
        instance.register(statisRoute, opts);
    }
    instance.register(routes);
    done();
});
