# Step 1: Build the React app using Vite
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (or yarn.lock) into the container
COPY package*.json ./ 

# Install the dependencies
RUN npm install

# Copy the rest of the app source into the container
COPY . .

# Build the app for production using Vite
RUN npm run build  # This will create the `dist` directory

# Step 2: Serve the React app with nginx
FROM nginx:alpine

# Copy the dist folder from the build image to the nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to the outside
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
