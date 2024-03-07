import { FastifyInstance } from "fastify";
import { User } from "../db/models.js";
import fastifyPlugin from "fastify-plugin";
const schema = {
    body: {
        type: "object",
        required: [
            "email",
            "name",
            "password",
            "address"
        ]
    }
};

function routes(instance: FastifyInstance, opts: any, done) {
    instance.get("/api/users", async function (request, reply) {
        const users = await this.db.getUsers();
        reply.send(users);
    });
    instance.post<{ Body: User }>("/api/users", { schema }, async function(request, reply) {
        try {
            const user = await this.db.insertUser(request.body);
            reply.statusCode = 201;
            reply.send(user);
        } catch (err:any) {
            reply.statusCode = 400;
            reply.send({error:err.message});
        }
    });
    done();
}

export default fastifyPlugin(routes);
