# Dockerized Next.js & Express.js App

This project contains a **Next.js** frontend and an **Express.js** backend, both containerized using Docker for easy deployment.

## Background

This approach was developed while migrating a **large-scale project** from **Vue 2 to Next.js** due to security vulnerabilities in Vue 2. The backend, built with Express.js, was stable and did not require changes. The challenge was to containerize the project efficiently.

Initially, I explored existing monorepo solutions, such as [this repository](https://github.com/hironate/express-js-next-js-docker-monorepo), but they built **two separate Docker images** for the frontend and backend. The requirement was to have a **single Docker image**, so I developed this optimized approach.

## Features

- **Multi-stage Docker build** for optimized image size
- **Production-ready setup** with minimal dependencies
- **Serves Next.js frontend and Express backend in a single container**
- **Uses ****`node:18-slim`**** for efficiency**

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Node.js](https://nodejs.org/) (for local development)

---

## Installation & Usage

### 1. Install Dependencies

To install all dependencies at once, run:

```
npm install && npm run setup
```

This will install dependencies for:

- The **root directory**
- The **frontend (Next.js)**
- The **backend (Express.js)**

Alternatively, you can install them manually:

```
npm install # Install root dependencies
cd frontend && npm install
cd ../backend && npm install
cd .. # Return to root directory
```

### Run in Development Mode

You can run both frontend and backend simultaneously using `concurrently`:

```
npm run dev
```

This will start:

- **Next.js frontend on port 3000**
- **Express backend on port 3001**

### 3. Build the Docker Image

```
npm run build
```

or

```
docker build -t next-express-docker .
```

### 4. Run the Container

```sh
docker run -p 3000:3000 -p 3001:3001 next-express-docker
```

### 5. Access the Application

- **Frontend (Next.js)**: [http://localhost:3000](http://localhost:3000)
- **Backend (Express.js API)**: [http://localhost:3001](http://localhost:3001)

---

## Project Structure

```
/project-root
│── frontend/  # Next.js frontend
│── backend/   # Express.js backend
│── Dockerfile # Docker build
│── package.json # Root package.json with concurrent scripts
│── README.md  # Documentation
```

---

## Dockerfile Breakdown

1. **Frontend Build Stage**
   - Installs dependencies and builds the Next.js app.
2. **Backend Build Stage**
   - Installs dependencies for the Express app.
3. **Final Production Stage**
   - Copies built frontend & backend files.
   - Installs only production dependencies.
   - Runs both frontend and backend in a single container.

---

## Environment Variables

You can configure environment variables using a `.env` file in both `frontend/` and `backend/` directories.

Example:

```
# Inside frontend/.env.local
NEXT_PUBLIC_API_URL=http://localhost:3001
```

```
# Inside backend/.env
PORT=3001
```

---

## License

This project is open-source and available under the [MIT License](LICENSE).

---

## Contributions

Feel free to open issues or submit pull requests to improve this project!

