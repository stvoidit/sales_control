import qs from "qs";

const qsOptions = { arrayFormat: "repeat", addQueryPrefix: true, skipNulls: true };


async function intercaptor(response) {
    if (response.status === 400) {
        const errorJSON = await response.json();
        throw new Error(errorJSON.error);
    }
    if (response.status === 401) {
        window.location.href = "/login";
    } else if (response.status > 401 && response.status < 500) {
        throw new Error(await response.text());
    }
    if (response.headers.get("content-type")?.includes("application/json")) {
        return await response.json();
    }
    return await response.text();
}


class API {
    async getUsers() {
        return await fetch("/api/users").then(intercaptor);
    }
    async getSalers() {
        return await fetch("/api/salers").then(intercaptor);
    }
    async getRetailOutlets() {
        return await fetch("/api/retail_outlets").then(intercaptor);
    }
    async getAppointments() {
        return await fetch("/api/appointments").then(intercaptor);
    }
    async createSaler(payload) {
        const options = {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify(payload)
        };
        return await fetch("/api/salers", options).then(intercaptor);
    }
    async deleteSaler(id) {
        const options = {
            method: "DELETE"
        };
        return await fetch(`/api/salers/${id}`, options).then(intercaptor);
    }
    async createAppointments(payload) {
        const options = {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify(payload)
        };
        return await fetch("/api/appointments", options).then(intercaptor);
    }
    async createRetailOutlet(payload) {
        const options = {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify(payload)
        };
        return await fetch("/api/retail_outlets", options).then(intercaptor);
    }
    async deleteRetailOutlet(id) {
        const options = {
            method: "DELETE"
        };
        return await fetch(`/api/retail_outlets/${id}`, options).then(intercaptor);
    }

    async getReportOption() {
        return await fetch("/api/report/options").then(intercaptor);
    }

    async sendReport(payload) {
        const options = {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify(payload)
        };
        return await (fetch("/api/report", options));
    }

    async getReportsLog(filters) {
        const params = qs.stringify(filters, qsOptions);
        return await fetch(`/api/report/logs${params}`).then(intercaptor);
    }

    async getActualPrices() {
        return await fetch("/api/prices/actual").then(intercaptor);
    }
    async updateActualPrice(payload) {
        const options = {
            method: "POST",
            headers: { "content-type": "application/json" },
            body: JSON.stringify(payload)
        };
        return await (fetch("/api/prices/actual", options));
    }

    async getHistoryPrices() {
        return await fetch("/api/prices/history").then(intercaptor);
    }
}


export default new API();
