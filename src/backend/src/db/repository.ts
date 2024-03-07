import { User } from "./models.js";
import bcrypt from "bcrypt";
import db from "./connect.js";

async function getUsers() {
    return await db<User[]>`
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

async function insertUser(user: User) {
    const passwordhash = await bcrypt.hash(user.password, 12);
    try {
        const result = await db<User[]>`
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



export {
    getUsers,
    insertUser
};
