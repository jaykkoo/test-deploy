sed -i 's/\[]/\["54.164.227.130"]/' /home/ubuntu/test-deploy/conf/settings.py

sudo mkdir -p /home/ubuntu/test-deploy/staticfiles
sudo mkdir -p /home/ubuntu/test-deploy/static

# Navigate to the project directory
cd /home/ubuntu/test-deploy || exit

# Ensure correct permissions for staticfiles directory
sudo chown -R ubuntu:www-data /home/ubuntu/test-deploy/staticfiles
sudo chmod -R 755 /home/ubuntu/test-deploy/staticfiles

# Run Django management commands
/home/ubuntu/venv/bin/python manage.py migrate
/home/ubuntu/venv/bin/python manage.py makemigrations
/home/ubuntu/venv/bin/python manage.py collectstatic --noinput

# Restart Gunicorn and Nginx servicesq
sudo service gunicorn restart
sudo service nginx restart