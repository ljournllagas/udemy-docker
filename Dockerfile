FROM node:alpine AS builder

ENV HTTP_PROXY "http://rbcproxy.robinsonsbank.com.ph:80"
ENV HTTPS_PROXY "http://rbcproxy.robinsonsbank.com.ph:80"

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
