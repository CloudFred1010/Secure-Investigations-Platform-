#!/bin/bash
set -e

echo "===================================="
echo "  Starting Investigations Platform  "
echo "===================================="

# Start backend (FastAPI) in background
echo "[1/2] Starting FastAPI backend..."
cd api
source ../.venv/bin/activate
uvicorn main:app --reload --port 8000 &
BACKEND_PID=$!
cd ..

# Start frontend (React) in background
echo "[2/2] Starting React frontend..."
cd app/web
npm start &
FRONTEND_PID=$!
cd ../..

echo "------------------------------------"
echo "Backend running at: http://127.0.0.1:8000"
echo "Frontend running at: http://localhost:3000"
echo "Press CTRL+C to stop both"
echo "------------------------------------"

# Trap exit to kill background processes
trap "echo 'Stopping...'; kill $BACKEND_PID $FRONTEND_PID" INT

# Wait for both to finish
wait
