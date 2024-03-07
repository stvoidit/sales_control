import { FastifyInstance } from "fastify";
import fastifyStatic from "@fastify/static";

type statisOptions = {staticDir?:string}

export default function (instance: FastifyInstance, opts: statisOptions, done) {
    if (opts.staticDir) {
        instance.register(fastifyStatic, {
            root: opts.staticDir,
            prefix: "/"
        });
        instance.setNotFoundHandler((request, reply) =>{
            reply.sendFile("index.html");
        });
    }
    done();
}
