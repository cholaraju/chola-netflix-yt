# ---------------------
# Build stage
# ---------------------
FROM node:18-bullseye AS builder

# Enable yarn v3
RUN corepack enable

# Install required packages to build native modules
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++

# Set working directory
WORKDIR /app

# Copy dependency definitions and Yarn config files
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn .yarn

# Set yarn version explicitly (to avoid using cached version)
RUN yarn set version 3.6.4

# Install dependencies using offline cache if present
RUN yarn install --immutable

# Prisma generate (ignore failure during build phase)
RUN yarn prisma generate || true

# Copy all source code
COPY . .

# Build the Next.js app
RUN yarn build

# ---------------------
# Production stage
# ---------------------
FROM node:18-bullseye

# Enable yarn
RUN corepack enable

# Set working directory
WORKDIR /app

# Copy built files from builder
COPY --from=builder /app .

# Expose port
EXPOSE 3000

# Set environment variable
ENV NODE_ENV=production

# Run app
CMD ["yarn", "start"]
