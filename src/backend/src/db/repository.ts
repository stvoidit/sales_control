import { Appointment, RetailOutlet, Saler, User } from "./models.js";

import { Sql } from "postgres";
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
            , login
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
                login
                , "password"
                , "name"
                , address
            )
            VALUES(
                ${user.login}
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
                u.login = ${data.login}`;
            if (result.length !== 1) {
                throw new Error("auth data invalide, check login or password");
            }
            const user = result[0];
            if (!(await bcrypt.compare(data.password, user.password))) {
                throw new Error("auth data invalide, check login or password");
            }
            user.password = undefined;
            return user;
        } catch (err: any) {
            throw new Error(err.detail||err.message);
        }
    }

    async getSalers() {
        return await this.sql<Saler[]>`
        SELECT
            id
            , "label"
            , description
            , created
        FROM public.salers`;
    }

    async insertSaler(data: Saler) {
        try {
            return await this.sql`
            INSERT
                INTO
                public.salers
                (
                    "label"
                    , description
                )
            VALUES(
                ${data.label}
                , ${data.description}
            )`;
        } catch (err: any) {
            throw new Error(err.detail||err.message);
        }
    }

    async deleteSaler(id: number) {
        return await this.sql`
        DELETE FROM public.salers
        WHERE id = ${id}`;
    }


    async getRetailOutlets() {
        return await this.sql<RetailOutlet[]>`
        SELECT id, "label", address, created
        FROM public.retail_outlets`;
    }
    async insertRetailOutlets(data: RetailOutlet) {
        try {
            return await this.sql`
            INSERT
                INTO
                public.retail_outlets
                (
                    "label"
                    , address
                )
            VALUES(
                ${data.label}
                , ${data.address}
            )`;
        } catch (err: any) {
            throw new Error(err.detail||err.message);
        }
    }
    async deleteRetailOutlets(id: number) {
        return await this.sql`
        DELETE FROM public.retail_outlets
        WHERE id = ${id}`;
    }

    async getAppointments() {
        return await this.sql<Appointment[]>`
        SELECT
            a.id
            , a.created
            , jsonb_build_object(
                'id'
                , u.id
                , 'login'
                , u.login
            ) AS "user"
            , jsonb_build_object(
                'id'
                , s.id
                , 'label'
                , s."label"
            ) AS "saler"
            , jsonb_build_object(
                'id'
                , ro.id
                , 'label'
                , ro."label"
                , 'address'
                , ro.address
            ) AS "retail_outlet"
        FROM
            appointments a
        LEFT JOIN users u ON
            u.id = a.login_id
        LEFT JOIN salers s ON
            s.id = a.saler_id
        LEFT JOIN retail_outlets ro ON
            ro.id = a.retail_outlet_id
        `;
    }
    async insertAppointments(data: Appointment) {
        try {
            return await this.sql`
            INSERT
                INTO
                public.appointments
                (
                    login_id
                    , saler_id
                    , retail_outlet_id
                )
            VALUES(
                ${data.user.id}
                , ${data.saler.id}
                , ${data.retail_outlet.id}
            )`;
        } catch (err: any) {
            throw new Error(err.detail||err.message);
        }
    }

}

export default DB;
