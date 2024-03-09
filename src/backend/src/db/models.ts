interface User {
    id: number;
    login: string;
    password?: string;
    name: string;
    address: string;
    created: Date
}


export {
    type User
};
