interface User {
    id: number;
    login: string;
    password?: string;
    name: string;
    address: string;
    created: Date
}

interface Saler {
    id?: number;
    label: string;
    description: string;
    created?: Date
}


export {
    type User,
    type Saler
};
