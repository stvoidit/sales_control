# compile in one file
FROM node:20-alpine AS compile-server
WORKDIR /app
RUN npm install --no-audit --progress=false -g pnpm
COPY src/backend/package.json src/backend/pnpm-lock.yaml src/backend/tsconfig.json src/backend/builder.js ./
RUN pnpm install
COPY src/backend/src src
RUN NODE_ENV=production pnpm build

# compile in one file
FROM node:20-alpine AS build-frontend
WORKDIR /app
RUN npm install --no-audit --progress=false -g pnpm
COPY src/frontend/package.json src/frontend/pnpm-lock.yaml src/frontend/vite.config.js src/frontend/index.html ./
RUN pnpm install
COPY src/frontend/src src
RUN NODE_ENV=production pnpm build

# application server
FROM node:20-alpine
RUN apk add tzdata && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" >/etc/timezone && apk del tzdata
COPY --from=compile-server /app/dist/app.mjs /usr/local/sales_control.mjs
COPY --from=build-frontend /app/dist /www/data/static
ENTRYPOINT [ "node", "/usr/local/sales_control.mjs" ]
