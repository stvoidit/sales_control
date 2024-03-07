import { FastifyInstance } from "fastify";
import { getUsers } from "../db/index.js";

async function routes(instance: FastifyInstance, opts: any) {
    instance.get("/api/users", async (request, reply) => {
        const users = await getUsers();
        reply.send(users);
    });
}

export default routes;
