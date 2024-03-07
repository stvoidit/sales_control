import { build } from "esbuild";

build({
    bundle: true,
    logLevel: "info",
    entryPoints: ["src/app.ts"],
    outfile: "dist/app.mjs",
    minify: false,
    minifyWhitespace: true,
    minifySyntax: true,
    minifyIdentifiers: true,
    format: "esm",
    target: "esnext",
    platform: "node",
    treeShaking: true,
    banner: {
        js: "import {createRequire} from \"module\";const require = createRequire(import.meta.url);"
    }
}).catch((error) => { console.error(error); process.exit(1); });
