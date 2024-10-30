# Use the official NGINX image as the base image
FROM nginx:latest

# Copy the HTML file to the NGINX web server directory
COPY ./html /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]