FROM node:18

# Create a non-root user
RUN useradd -m appuser

# Set working directory
WORKDIR /app

# Copy package.json first, install dependencies
COPY package*.json ./
RUN npm install

# Copy remaining app files
COPY . .

# Make app files owned by non-root user
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port and run app
EXPOSE 5000
CMD ["node", "index.js"]
