import { FastifyInstance } from "fastify";
import { User } from "../db/models.js";
import fastifyPlugin from "fastify-plugin";
const schema = {
    body: {
        type: "object",
        required: [
            "login",
            "name",
            "password",
            "address"
        ]
    }
};

function routes(instance: FastifyInstance, opts: any, done) {
    instance.get("/api/users", async function (request, reply) {
        this.log.debug({msg: "ctxUser", obj: {...request.ctxUser}} );
        reply.send(await this.db.getUsers());
    });
    instance.post<{ Body: User }>("/api/users", { schema }, async function(request, reply) {
        try {
            this.log.debug(request.body);
            const user = await this.db.insertUser(request.body);
            this.log.debug(user);
            reply.code(201).send(user);
        } catch (err:any) {
            reply.code(400).send({error:err.message});
        }
    });
    instance.get("/api/salers", async function (request, reply) {
        reply.send(await this.db.getSalers());
    });
    done();
}

export default fastifyPlugin(routes);
