FROM node:20-alpine3.21 As builder
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine3.21
RUN addgroup -S roboshop 
RUN adduser -S roboshop -G roboshop
ENV MONGO="true"
ENV MONGO_URL="mongodb://mongodb:27017/catalogue"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node","server.js"]



# #FROM node:20
# FROM node:20-alpine3.21
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# WORKDIR /opt/server
# USER roboshop
# COPY package.json .
# COPY *.js .
# RUN npm install
# RUN chown -R roboshop:roboshop /opt/server
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# USER roboshop
# CMD ["node", "server.js"]