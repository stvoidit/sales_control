interface User {
    id: number;
    email: string;
    password?: string;
    name: string;
    address: string;
    created: Date
}


export {
    type User
};
