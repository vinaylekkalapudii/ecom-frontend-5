# Step 1: Build the React app
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (or yarn.lock) into the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the React app into the container
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the React app with nginx
FROM nginx:alpine

# Copy the build folder from the build image to the nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
