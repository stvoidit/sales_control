import { build } from "pino-pretty";
import {pino} from "pino";
export default pino(build({ colorize: true, singleLine: true }));
