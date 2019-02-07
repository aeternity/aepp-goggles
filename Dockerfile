FROM node:10.15.1-alpine as aepp-goggles-build
WORKDIR /app
RUN apk add make gcc g++ python
COPY  . .
RUN npm install && npm run build

FROM nginx:1.13.7-alpine

COPY --from=aepp-goggles-build /app/dist /usr/share/nginx/html
COPY LICENSE /usr/share/nginx/html
