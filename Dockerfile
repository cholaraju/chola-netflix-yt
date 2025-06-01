# 1. Build stage
FROM node:18-alpine AS builder

# Install dependencies needed for native modules like sharp/prisma
RUN apk add --no-cache \
  python3 \
  make \
  g++ \
  && corepack enable

WORKDIR /app
COPY . .

# Install dependencies with correct Yarn version
RUN yarn set version 3.6.4
RUN yarn install

RUN yarn build

# 2. Production stage
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
ENV NODE_ENV=production

CMD ["yarn", "start"]
