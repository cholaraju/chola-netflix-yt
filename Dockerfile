# 1. Build stage
FROM node:18-alpine AS builder

# Enable Corepack and set Yarn version
RUN corepack enable && corepack prepare yarn@3.6.4 --activate

WORKDIR /app
COPY . .

# Verify Yarn version (optional)
RUN yarn --version

RUN yarn install
RUN yarn build

# 2. Production stage
FROM node:18-alpine

# Enable Corepack and set Yarn version in production container too
RUN corepack enable && corepack prepare yarn@3.6.4 --activate

WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
ENV NODE_ENV=production
CMD ["yarn", "start"]
