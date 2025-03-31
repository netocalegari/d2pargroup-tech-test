FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
# This copies your src, public, config files, etc.
COPY . .

# Start the development server with host flag
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]