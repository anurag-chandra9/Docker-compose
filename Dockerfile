FROM node:20-alpine

WORKDIR /app

COPY ./package.json ./package.json 
COPY ./package-lock.json ./package-lock.json
RUN npm install

COPY  . .
ENV DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres
RUN echo $DATABASE_URL

RUN DATABASE_URL=$DATABASE_URL npx prisma migrate 
RUN npx prisma generate
RUN npm run build
EXPOSE  3000

CMD ["npm", "start"]



# #FROM node:20-alpine

# WORKDIR /app

# COPY ./package.json ./package.json 
# COPY ./package-lock.json ./package-lock.json
# RUN npm install

# COPY . .

# # Use service name instead of localhost
# ENV DATABASE_URL=postgresql://postgres:mysecretpassword@postgres:5432/postgres

# # Generate Prisma client (this does NOT need a running DB)
# RUN npx prisma generate

# RUN npm run build

# EXPOSE 3000

# # At runtime: run migrations against the real DB, then start the app
# CMD npx prisma migrate deploy && npm start
