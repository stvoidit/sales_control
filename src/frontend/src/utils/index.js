import { date } from "quasar";

const localDateFormat = "DD.MM.YYYY";
const validDateFormat = "YYYY-MM-DD";

export function toValidDateString(str) {
    return date.formatDate(date.extractDate(str, localDateFormat), validDateFormat);
}

export function toLocalDateString(d) {
    return date.formatDate(d, localDateFormat);
}
