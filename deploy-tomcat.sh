#!/bin/bash

echo "========================================="
echo "🏨 Hotel Management System - Deploy to Tomcat"
echo "========================================="
echo ""

# Đường dẫn Tomcat
TOMCAT_WEBAPPS="/opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/webapps/"
WAR_NAME="myapp.war"

echo "📦 Step 1: Building project..."
mvn clean package

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

echo ""
echo "✅ Build successful!"
echo ""
echo "📋 Step 2: Deploying to Tomcat..."

if [ ! -f "target/$WAR_NAME" ]; then
    echo "❌ WAR file not found: target/$WAR_NAME"
    exit 1
fi

echo "Copying $WAR_NAME to Tomcat webapps..."
sudo cp "target/$WAR_NAME" "$TOMCAT_WEBAPPS"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment successful!"
    echo ""
    echo "========================================="
    echo "🚀 Application deployed to Tomcat"
    echo "========================================="
    echo ""
    echo "📍 Access your application at:"
    echo "   http://localhost:8080/myapp"
    echo ""
    echo "📝 To start Tomcat (if not running):"
    echo "   brew services start tomcat@9"
    echo ""
    echo "📝 To stop Tomcat:"
    echo "   brew services stop tomcat@9"
    echo ""
    echo "📝 To check Tomcat status:"
    echo "   brew services list | grep tomcat"
    echo ""
    echo "📝 To view Tomcat logs:"
    echo "   tail -f /opt/homebrew/Cellar/tomcat@9/9.0.112/libexec/logs/catalina.out"
    echo ""
else
    echo "❌ Deployment failed!"
    echo "Make sure you have permission to write to Tomcat directory"
    exit 1
fi
