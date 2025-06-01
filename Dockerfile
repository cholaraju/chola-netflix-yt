# 1. Build stage
# 1. Build stage
FROM node:18-bullseye AS builder

# Enable Corepack for Yarn v3 support
RUN corepack enable

WORKDIR /app
COPY . .

# Use the correct Yarn version defined in package.json
RUN yarn set version 3.6.4

# Install dependencies
RUN yarn install

# Generate Prisma client (if you use Prisma)
RUN yarn prisma generate || true

# Build your application
RUN yarn build

# 2. Production stage
FROM node:18-bullseye

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000
ENV NODE_ENV=production

CMD ["yarn", "start"]

