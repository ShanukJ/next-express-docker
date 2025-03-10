# Step 1: Build the Next.js frontend
FROM node:18-slim AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install --frozen-lockfile
COPY frontend ./
RUN npm run build

# Step 2: Build the Express backend
FROM node:18-slim AS backend-builder
WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install --frozen-lockfile
COPY backend ./

# Step 3: Create a lightweight production image
FROM node:18-slim
WORKDIR /app

# Install only production dependencies for frontend
COPY --from=frontend-builder /app/frontend/package.json /app/frontend/package.json
COPY --from=frontend-builder /app/frontend/package-lock.json /app/frontend/package-lock.json
RUN cd /app/frontend && npm install --frozen-lockfile --production

# Copy frontend build and necessary files
COPY --from=frontend-builder /app/frontend/.next /app/frontend/.next
COPY --from=frontend-builder /app/frontend/public /app/frontend/public

# Install only production dependencies for backend
COPY --from=backend-builder /app/backend /app/backend
RUN cd /app/backend && npm install --frozen-lockfile --production

# Expose necessary ports
EXPOSE 3000 3001

# Set the start command to run both frontend and backend
CMD ["sh", "-c", "npm run start --prefix /app/frontend & node /app/backend/server.js"]
