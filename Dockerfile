FROM nginx:1.13.7-alpine

COPY dist /usr/share/nginx/html
COPY LICENSE /usr/share/nginx/html
