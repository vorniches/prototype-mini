#!/bin/bash

# 1) Create app structure if it doesn't exist
if [ ! -d "app" ]; then
    mkdir -p app/helpers
    touch app/__init__.py
    touch app/helpers/__init__.py
    
    # Create main.py
    cat > app/main.py << 'EOF'
import os
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(
    title="Prototype-Mini",
    description="A FastAPI quick-start template with OpenAI integration",
    version="1.0.0"
)

@app.get("/")
async def root():
    return {
        "message": "Welcome to Prototype-Mini!",
        "status": "running",
        "docs": "/docs"
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.post("/ask")
async def ask_openai(system_prompt: str, user_prompt: str):
    from app.helpers.openai_helper import send_prompt_to_openai
    
    response = send_prompt_to_openai(
        system_content=system_prompt,
        user_prompt=user_prompt
    )
    
    if response:
        return JSONResponse(content={"success": True, "response": response})
    else:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": "Failed to get response from OpenAI"}
        )
EOF
fi

# 2) Move openai_helper.py into helpers folder
if [ -f "openai_helper.py" ]; then
    mv openai_helper.py app/helpers/
fi

# 3) Build & run containers
docker-compose build --no-cache
docker-compose up -d

# 4) Remove the .git folder if it exists
if [ -d ".git" ]; then
    rm -rf .git
    echo ".git folder removed. You can now initialize your own Git repository."
fi