import { getUsers, insertUser } from "./repository.js";

import db from "./connect.js";

async function closeDatabaseConnection() {
    return await db.end();
}

export {
    closeDatabaseConnection,
    getUsers,
    insertUser
};
