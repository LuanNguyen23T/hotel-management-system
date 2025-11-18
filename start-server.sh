#!/bin/bash
cd "/Users/bnhan2710/Documents/source-code/CNW/myapp"
echo "========================================="
echo "Starting Tomcat Server..."
echo "Server will run at: http://localhost:8080/myapp"
echo "Login page: http://localhost:8080/myapp/auth?action=login"
echo "========================================="
echo ""
echo "Watch for LOGIN messages in the output below:"
echo ""
mvn tomcat7:run
