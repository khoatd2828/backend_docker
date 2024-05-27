FROM node:20

WORKDIR /home/node41

#node module    
COPY package*.json .

RUN yarn config set network-timeout 3000000

RUN yarn install

COPY prisma ./prisma

RUN yarn prisma generate

COPY . .

EXPOSE 8080

CMD ["yarn","prod"]

# node src/index.js
# yarn start
# yarn prod

# docker build . -t img-node
# docker run -d -p 8080:8080 --name cons-node --network node-network img-node