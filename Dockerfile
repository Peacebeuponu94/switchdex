FROM  node:12-alpine@sha256:d4b15b3d48f42059a15bd659be60afe21762aae9d6cbea6f124440895c27db68 as yarn-install
WORKDIR /app
COPY package.json yarn.lock ./
RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual build-dependencies bash git openssh python make g++ && \
    yarn --no-cache || \
    apk del build-dependencies && \
    yarn cache clean

# Stage 1
FROM  node:12-alpine as react-build
WORKDIR /app
COPY --from=yarn-install /app/node_modules /app/node_modules
COPY . .
RUN yarn build

# Stage 2 - the production environment
FROM nginx:alpine
COPY --from=react-build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
