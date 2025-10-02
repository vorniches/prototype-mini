# Prototype-Mini

This is a quick-start template for setting up a **FastAPI** microservice with **OpenAI integration**. Perfect for building lightweight API prototypes where a UI isn't needed initially. The project is containerized with Docker for easy setup and deployment.

> **Prototype-Mini** is the lightweight FastAPI version of [Prototype](https://github.com/vorniches/prototype). Use **Prototype** for full-stack Django projects with UI, and **Prototype-Mini** for fast API-only microservices.

## Requirements

Before starting, ensure you have:

- **Docker** and **Docker Compose** installed (latest versions recommended)

## Quick Start

### Step 1: Clone the repository

```bash
git clone https://github.com/vorniches/prototype-mini your_app_name
cd your_app_name
```

### Step 2: Start the project

Run the following command to set up the environment:

```bash
./setup.sh
```

This will:

1. Create the FastAPI project structure (if not already present)
2. Move the `openai_helper.py` to the appropriate directory
3. Build and start the Docker containers

## Access the Application

The FastAPI server will be available at:

- [http://localhost:9019](http://localhost:9019)
- [http://localhost:9019/docs](http://localhost:9019/docs) (Interactive API Docs)

## Configuration

### Environment Variables

1. Copy the `example.env` file to `.env`:

   ```bash
   cp example.env .env
   ```

2. Edit `.env` to include your OpenAI API key:

   ```bash
   OPENAI_API_KEY=<your_openai_api_key>
   ```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.