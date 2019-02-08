FROM node:10.15.1-alpine as aepp-goggles-build
ARG NODE_URL
ARG NODE_INTERNAL_URL
WORKDIR /app
RUN apk add make gcc g++ python git
COPY  . .
RUN npm install
RUN NODE_URL=$NODE_URL NODE_INTERNAL_URL=$NODE_INTERNAL_URL npm run build

FROM nginx:1.13.7-alpine

COPY --from=aepp-goggles-build /app/dist /usr/share/nginx/html
COPY LICENSE /usr/share/nginx/html
