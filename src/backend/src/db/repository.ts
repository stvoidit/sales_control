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
}

export default DB;
