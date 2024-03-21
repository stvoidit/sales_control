import { date } from "quasar";
const { formatDate, extractDate } = date;

const localDateFormat = "DD.MM.YYYY";
const validDateFormat = "YYYY-MM-DD";

export function toValidDateString(str) {
    return formatDate(extractDate(str, localDateFormat), validDateFormat);
}

export function toLocalDateString(d) {
    return formatDate(d, localDateFormat);
}

export {
    extractDate,
    formatDate
};
