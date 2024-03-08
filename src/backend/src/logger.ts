import { build } from "pino-pretty";
import { pino } from "pino";
const logger = pino(build({
    colorize: true,
    singleLine: true,
    translateTime: true
}));
logger.level = "debug";
export default logger;
