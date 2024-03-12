import { RetailOutlet, Saler, User } from "../db/models.js";

import { FastifyInstance } from "fastify";
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
    instance.get("/api/init", async function (request, reply) {
        this.log.debug({msg: "ctxUser", obj: {...request.ctxUser}} );
        reply.send(request.ctxUser);
    });
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
        } catch (err: any) {
            this.log.error(err);
            reply.code(400).send({error:err.message});
        }
    });
    instance.get("/api/salers", async function (request, reply) {
        reply.send(await this.db.getSalers());
    });
    instance.post<{ Body: RetailOutlet }>("/api/salers", async function(request, reply) {
        try {
            this.log.debug(request.body);
            await this.db.insertSaler(request.body);
            reply.code(201);
        } catch (err: any) {
            this.log.error(err);
            reply.code(400).send({error:err.message});
        }
    });
    instance.delete("/api/salers/:id", async function(request, reply) {
        try {
            this.log.debug(request.params.id);
            await this.db.deleteSaler(request.params.id);
            reply.code(200);
        } catch (err: any) {
            this.log.error(err);
            reply.code(400).send({error:err.message});
        }
    });

    instance.get("/api/retail_outlets", async function (request, reply) {
        reply.send(await this.db.getRetailOutlets());
    });
    instance.post<{ Body: Saler }>("/api/retail_outlets", async function(request, reply) {
        try {
            this.log.debug(request.body);
            await this.db.insertRetailOutlets(request.body);
            reply.code(201);
        } catch (err: any) {
            this.log.error(err);
            reply.code(400).send({error:err.message});
        }
    });
    instance.delete("/api/retail_outlets/:id", async function(request, reply) {
        try {
            this.log.debug(request.params.id);
            await this.db.deleteRetailOutlets(request.params.id);
            reply.code(200);
        } catch (err: any) {
            this.log.error(err);
            reply.code(400).send({error:err.message});
        }
    });
    done();
}

export default fastifyPlugin(routes);
