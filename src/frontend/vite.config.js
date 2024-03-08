import { defineConfig, loadEnv } from "vite";

import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { ElementPlusResolver } from "unplugin-vue-components/resolvers";
import { resolve } from "path";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default ({ mode }) => {
    const env = loadEnv(mode, ".");
    return defineConfig({
        plugins: [
            vue(),
            AutoImport({
                resolvers: [ElementPlusResolver()]
            }),
            Components({
                resolvers: [ElementPlusResolver()]
            })
        ],
        server: {
            proxy: {
                "/api": {
                    target: env.VITE_PROXY_TARGET || "http://localhost:8080",
                    changeOrigin: true
                }
            },
            host: env.VITE_HOST || "0.0.0.0",
            port: parseInt(env.VITE_PORT) || 3000
        },
        build: {
            target: "modules",
            outDir: "dist",
            manifest: false,
            minify: "esbuild",
            emptyOutDir: true,
            sourcemap: false,
            cssCodeSplit: false,
            chunkSizeWarningLimit: 2 << 10
        },
        resolve: {
            alias: [
                {
                    find: "@",
                    replacement: resolve(__dirname, "src")
                }
            ]
        }
    });
};
