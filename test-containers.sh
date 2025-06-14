#!/bin/bash
echo "Testing containerized application..."

# Test 1: Check if all containers are running
echo "1. Checking container status..."
if docker-compose ps | grep -q "Up"; then
    echo "   ✓ Containers are running"
else
    echo "   ✗ Some containers are not running"
    exit 1
fi

# Test 2: Test frontend accessibility
echo "2. Testing frontend (port 80)..."
if curl -f http://localhost:80 > /dev/null 2>&1; then
    echo "   ✓ Frontend is accessible"
else
    echo "   ✗ Frontend is not accessible"
fi

# Test 3: Test backend API
echo "3. Testing backend API (port 5000)..."
if curl -f http://localhost:5000/todos?page=1&limit=0 > /dev/null 2>&1; then
    echo "   ✓ Backend API is accessible"
else
    echo "   ✗ Backend API is not accessible"
fi

# Test 4: Test MongoDB connection
echo "4. Testing MongoDB connection..."
if docker compose exec -T mongo mongosh --eval "db.adminCommand('ping')" > /dev/null 2>&1; then
    echo "   ✓ MongoDB is accessible"
else
    echo "   ✗ MongoDB is not accessible"
fi

# Test 5: Test inter-service communication
echo "5. Testing backend-to-database communication..."
if docker compose exec -T backend node -e "
const mongoose = require('mongoose');
mongoose.connect('mongodb://mongo:27017/todo-db')
  .then(() => { console.log('Connection successful'); process.exit(0); })
  .catch(() => { console.log('Connection failed'); process.exit(1); })
" 2>/dev/null | grep -q "Connection successful"; then
    echo "   ✓ Backend can connect to MongoDB"
else
    echo "   ✗ Backend cannot connect to MongoDB"
fi

echo "Testing complete!"
