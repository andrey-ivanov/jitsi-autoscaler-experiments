FROM --platform=$TARGETPLATFORM node:20
ARG TARGETPLATFORM

# install dependencies
RUN apt-get update && apt-get -y install linux-perf

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy env
COPY ./.env .

# Copy scripts
COPY ./scripts ./scripts

# Copy built app
COPY ./dist/. .

# Run app
EXPOSE 8080
ENV NODE_ENV=production
CMD ["node", "/usr/src/app/app.js"]
