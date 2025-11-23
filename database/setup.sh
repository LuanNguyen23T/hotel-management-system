#!/bin/bash

echo "🏨 Hotel Management - MySQL Database Setup"
echo "=========================================="
echo ""
echo "📦 Detecting MySQL installation..."
echo ""

# Check for XAMPP MySQL
if [ -f "/Applications/XAMPP/bin/mysql" ]; then
    MYSQL_CMD="/Applications/XAMPP/bin/mysql"
    echo "✅ Found XAMPP MySQL"
elif command -v mysql &> /dev/null; then
    MYSQL_CMD="mysql"
    echo "✅ Found MySQL in PATH"
else
    echo "❌ MySQL is not found!"
    echo "Please install MySQL or XAMPP first"
    echo "  XAMPP: https://www.apachefriends.org/download.html"
    exit 1
fi

echo ""
echo "⚙️  MySQL Configuration"
echo "------------------------"

# Prompt for MySQL credentials
read -p "Enter MySQL username [root]: " DB_USER
DB_USER=${DB_USER:-root}

read -sp "Enter MySQL password (press Enter if no password): " DB_PASSWORD
echo ""
echo ""

# Test connection
echo "Testing MySQL connection..."
if [ -z "$DB_PASSWORD" ]; then
    # No password
    if $MYSQL_CMD -u"$DB_USER" -e "SELECT 1" > /dev/null 2>&1; then
        echo "✅ Connected to MySQL successfully!"
    else
        echo "❌ Failed to connect to MySQL. Please check your credentials."
        exit 1
    fi
else
    # With password
    if $MYSQL_CMD -u"$DB_USER" -p"$DB_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; then
        echo "✅ Connected to MySQL successfully!"
    else
        echo "❌ Failed to connect to MySQL. Please check your credentials."
        exit 1
    fi
fi

echo ""
echo "📊 Creating database and tables..."

# Determine the correct path to schema.sql
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_FILE="$SCRIPT_DIR/schema.sql"

# Run schema.sql
if [ -z "$DB_PASSWORD" ]; then
    $MYSQL_CMD -u"$DB_USER" < "$SCHEMA_FILE"
else
    $MYSQL_CMD -u"$DB_USER" -p"$DB_PASSWORD" < "$SCHEMA_FILE"
fi

if [ $? -eq 0 ]; then
    echo "✅ Database setup completed successfully!"
    echo ""
    echo "📊 Database Information:"
    echo "   Database: hotel_management"
    echo "   Tables: rooms, customers, bookings, users"
    echo ""
    echo "📝 Sample Data:"
    echo "   - 7 rooms"
    echo "   - 3 customers"
    echo "   - 2 bookings"
    echo "   - 1 admin user (username: admin, password: admin123)"
    echo ""
    echo "⚙️  Next Steps:"
    echo "   1. Update DatabaseConfig.java with your MySQL credentials"
    echo "   2. Rebuild the project: mvn clean package"
    echo "   3. Run the application: mvn jetty:run"
    echo "   4. Access: http://localhost:8080/myapp/dashboard"
else
    echo "❌ Database setup failed!"
    exit 1
fi
