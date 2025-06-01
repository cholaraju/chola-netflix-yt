# Build stage
FROM node:18-bullseye AS builder

# Install dependencies needed for Prisma and Sharp
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  pkg-config \
  libvips-dev \
  && corepack enable

WORKDIR /app

# Copy dependency files
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn .yarn

# Set Yarn version and install deps
RUN yarn set version 3.6.4
RUN yarn install

# Needed for Yarn PnP to resolve binaries like `next`
ENV NODE_OPTIONS=--require=.pnp.cjs

# Copy remaining files
COPY . .

# Generate Prisma client (tolerate failures in CI)
RUN yarn prisma generate || true

# Build the app
RUN yarn build

# Production stage
FROM node:18-bullseye

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000
ENV NODE_ENV=production

CMD ["yarn", "start"]
