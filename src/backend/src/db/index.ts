import DB from "./repository.js";
import { FastifyInstance } from "fastify";
import fastifyPlugin from "fastify-plugin";
import postgres from "postgres";

export default fastifyPlugin(function (instance: FastifyInstance, opts, done) {
    const conn = postgres({
        database: "sales_control"
    });
    const db = new DB(conn);
    instance.decorate("db", db);
    done();
});
