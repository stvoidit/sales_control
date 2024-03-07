import { getUsers, insertUser } from "../db/index.js";

import { FastifyInstance } from "fastify";
import { User } from "../db/models.js";

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

async function routes(instance: FastifyInstance, opts: any) {
    instance.get("/api/users", async (request, reply) => {
        const users = await getUsers();
        reply.send(users);
    });
    instance.post<{ Body: User }>("/api/users", { schema }, async (request, reply) => {
        try {
            const user = await insertUser(request.body);
            reply.statusCode = 201;
            reply.send(user);
        } catch (err:any) {
            reply.statusCode = 400;
            reply.send({error:err.message});
        }

    });
}

export default routes;
