import { Users } from "./models.js";
import db from "./connect.js";

async function getUsers() {
    return await db<Users[]>`
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



export {
    getUsers
};
