interface User {
    id: number;
    login: string;
    password?: string;
    name: string;
    address: string;
    created: Date
}

interface RetailOutlet {
    id: number;
    label: string;
    address: string;
    created: Date;
}
interface Saler {
    id?: number;
    label: string;
    description: string;
    retail_outlets?: RetailOutlet[]
    created?: Date
}

interface Appointment {
    id?: number;
    user: User;
    saler: Saler;
    retail_outlet: RetailOutlet;
    created?: Date
}


interface Report {
    user_id?: number;
    saler_id: number,
    retail_outlet_id: number,
    report_date: Date,
    report: {
        val: number,
        bl: number,
        nal: number
    }
}

export {
    type User,
    type Saler,
    type RetailOutlet,
    type Appointment,
    type Report
};
