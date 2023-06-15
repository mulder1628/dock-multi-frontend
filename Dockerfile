FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- stuff we care about from the build phase
FROM nginx
# copy something from the builder phase
# source: /app/build
# destination: /usr/share/nginx/html (see https://hub.docker.com/_/nginx)
COPY --from=builder /app/build /usr/share/nginx/html
# don't need to specifically start up nginx, it does automagically