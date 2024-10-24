#!/bin/bash

echo "Updating ALLOWED_HOSTS in settings.py..."
if sed -i 's/\[]/\["54.164.227.130"]/' /home/ubuntu/test-deploy/conf/settings.py; then
    echo "ALLOWED_HOSTS updated successfully."
else
    echo "Failed to update ALLOWED_HOSTS." >&2
    exit 1
fi

# Navigate to the project directory
echo "Navigating to the project directory..."
cd /home/ubuntu/test-deploy || { echo "Failed to navigate to project directory."; exit 1; }

# Ensure correct permissions for staticfiles directory
echo "Ensuring correct permissions for staticfiles directory..."
if sudo chown -R ubuntu:www-data /home/ubuntu/test-deploy/staticfiles && \
   sudo chmod -R 755 /home/ubuntu/test-deploy/staticfiles; then
    echo "Permissions updated successfully."
else
    echo "Failed to update permissions." >&2
    exit 1
fi

# Run Django management commands
echo "Running Django migrations..."
if /home/ubuntu/venv/bin/python manage.py migrate; then
    echo "Migrations applied successfully."
else
    echo "Migrations failed." >&2
    exit 1
fi

echo "Creating new migrations..."
if /home/ubuntu/venv/bin/python manage.py makemigrations; then
    echo "Migrations created successfully."
else
    echo "Failed to create migrations." >&2
    exit 1
fi

echo "Collecting static files..."
if /home/ubuntu/venv/bin/python manage.py collectstatic --noinput; then
    echo "Static files collected successfully."
else
    echo "Failed to collect static files." >&2
    exit 1
fi

# Restart Gunicorn and Nginx services
echo "Restarting Gunicorn..."
if sudo service gunicorn restart; then
    echo "Gunicorn restarted successfully."
else
    echo "Failed to restart Gunicorn." >&2
    exit 1
fi

echo "Restarting Nginx..."
if sudo service nginx restart; then
    echo "Nginx restarted successfully."
else
    echo "Failed to restart Nginx." >&2
    exit 1
fi

echo "Application deployment completed successfully."
