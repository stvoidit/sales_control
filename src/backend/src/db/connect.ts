import postgres from "postgres";
const db = postgres({
    database: "sales_control"
});
export default db;
