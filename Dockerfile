# 1. Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# 2. Production stage
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app .
EXPOSE 3000
ENV NODE_ENV=production
CMD ["yarn", "start"]
