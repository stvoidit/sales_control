import { Buffer } from "node:buffer";
import type { FastifyCookieOptions } from "@fastify/cookie";
import { FastifyInstance } from "fastify";
import { User } from "../db/models.js";
import cookie from "@fastify/cookie";
import fastifyPlugin from "fastify-plugin";

export default fastifyPlugin(function (instance: FastifyInstance, opts: any, done) {
    const cookiOptions: FastifyCookieOptions = {
        secret: "randomString",
        hook: "onRequest",
        parseOptions: {
            domain: process.env.DOMAIN,
            httpOnly: true,
            path: "/",
            sameSite: true,
            secure: process.env.DOMAIN ? true : false,
            signed: true
        }
    };
    instance.register(cookie, cookiOptions);
    instance.decorateRequest("ctxUser", null);
    instance.addHook("onRequest", async (request, reply) => {
        instance.log.debug({
            url: request.url,
            cookies: request.cookies.profile
        }, "middleware");
        if (request.url.startsWith("/api") && !request.url.startsWith("/api/login")) {
            const { valid, value } = reply.unsignCookie(request.cookies.profile||"");
            if (!valid || !value) {
                reply.code(401).send("Unauthorized");
            } else {
                /**
                 * TODO: проверка токена, проверка юзера, обогащение контекста
                 */
                request.ctxUser = JSON.parse(Buffer.from(value, "base64").toString("utf-8")) as User;
            }
        }
    });
    instance.post<{ Body: { login: string, password: string } }>("/api/login", async function (request, reply) {
        try {
            this.log.debug(request.body);
            const user = await this.db.checkUserLogin(request.body);
            this.log.debug(user);
            reply.cookie("profile", Buffer.from(JSON.stringify(user), "utf-8").toString("base64"));
        } catch (err: any) {
            reply.code(400).send({error:err.message});
        }
    });
    done();
});
