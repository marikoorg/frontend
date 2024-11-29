FROM node:16-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]