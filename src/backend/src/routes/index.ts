import { FastifyInstance } from "fastify";
import fastifyPlugin from "fastify-plugin";
import middleware from "./middleware.js";
import routes from "./endpoints.js";
import statisRoute from "./statis.js";

export default fastifyPlugin(function (instance: FastifyInstance, opts: any, done) {
    instance.register(middleware);
    instance.register(routes);
    instance.register(statisRoute, opts);
    done();
});
