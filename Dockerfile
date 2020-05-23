# Specify a base image
# FROM node[:6.14]
# FROM node[alpine]
# Those are forms of getting a specific version of the node image. alpine is a version
# The `alpine` would have only the specific of that image, in this case node and anything else

FROM node:alpine

# Use that directory to set the path relative when copying files
WORKDIR /usr/app

# Copy files inside the container
COPY ./package.json ./
# Install some dependencies
RUN npm install

COPY ./ ./

# Run a default command
CMD ["npm", "start"]