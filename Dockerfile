FROM node:18-alpine as builder
WORKDIR /app
COPY package.json /app/package.json
RUN npm install --only=prod
COPY . /app
RUN npm run build

FROM nginx:1.16.0-alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/build /user/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]