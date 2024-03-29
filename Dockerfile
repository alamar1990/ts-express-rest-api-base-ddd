FROM node:18.12-alpine
ENV NODE_ENV production
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY package*.json ./
COPY . .

RUN npm install typescript -g

RUN npm install
RUN npm install -g pm2

RUN npm install -g fix-has-install-script
RUN fix-has-install-script

#Run build without stopping image generation due typescript warnings
RUN npm run build || :

#Remove sources from image
RUN rm -r src; rm -r .git

EXPOSE 3000
CMD [ "npm", "run", "start" ]

