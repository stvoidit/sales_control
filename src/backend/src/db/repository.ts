import { Sql } from "postgres";
import { User } from "./models.js";
import bcrypt from "bcryptjs";

class DB {
    sql: Sql;
    constructor(sql: Sql) {
        this.sql = sql;
    }
    async end() {
        await this.sql.end();
    }
    async getUsers() {
        return await this.sql<User[]>`
        SELECT
            id
            , email
            , "name"
            , address
            , created
        FROM
            public.users
        ORDER BY id ASC`;
    }
    async insertUser(user: User) {
        const passwordhash = bcrypt.hashSync(user.password, 12);
        try {
            const result = await this.sql<User[]>`
            INSERT INTO public.users
            (
                email
                , "password"
                , "name"
                , address
            )
            VALUES(
                ${user.email}
                , ${passwordhash}
                , ${user.name}
                , ${user.address}
            )
            RETURNING *`;
            return result;
        } catch (err: any) {
            throw new Error(err.detail);
        }
    }

    async checkUserLogin(data: { login: string, password: string }) {
        try {
            const result = await this.sql<User[]>`
            SELECT
                u.id
                , u."name"
                , u."password"
            FROM
                users u
            WHERE
                u.email = ${data.login}`;
            if (result.length !== 1) {
                throw new Error("auth data invalide, check email or password");
            }
            const user = result[0];
            if (!(await bcrypt.compare(data.password, user.password))) {
                throw new Error("auth data invalide, check email or password");
            }
            user.password = undefined;
            return user;
        } catch (err: any) {
            throw new Error(err.detail||err.message);
        }
    }
}

export default DB;
