# Build stage
FROM node:18-bullseye AS builder

RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  && corepack enable

WORKDIR /app

# Copy dependency files
COPY package.json yarn.lock .yarnrc.yml ./

RUN yarn set version 3.6.4
RUN yarn install

# Copy app files
COPY . .

RUN yarn prisma generate || true
RUN yarn build

# Production stage
FROM node:18-bullseye

WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
ENV NODE_ENV=production

CMD ["yarn", "start"]
