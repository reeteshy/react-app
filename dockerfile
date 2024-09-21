# Step 1: Use an official Node.js runtime as a parent image
FROM node:22 as build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the container
COPY package*.json ./

# Step 4: Install the app dependencies inside the container
RUN npm install

# Step 5: Copy the rest of the application code to the container
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use an NGINX image to serve the static files
FROM nginx:alpine

# Step 8: Copy the build files to the NGINX html folder
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start NGINX
CMD ["nginx", "-g", "daemon off;"]
