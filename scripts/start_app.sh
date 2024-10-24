#!/usr/bin/bash 

# sed -i 's/\[]/\["54.164.227.130"]/' /home/ubuntu/test-deploy/conf/settings.py

# sudo cd /home/ubuntu/test-deploy
# touch filename.txt

# python manage.py migrate 
# python manage.py makemigrations     
# python manage.py collectstatic
# sudo service gunicorn restart
# sudo service nginx restart
#sudo tail -f /var/log/nginx/error.log
#sudo systemctl reload nginx
#sudo tail -f /var/log/nginx/error.log
#sudo nginx -t
#sudo systemctl restart gunicorn
#sudo systemctl status gunicorn
#sudo systemctl status nginx
# Check the status
#systemctl status gunicorn
# Restart:
#systemctl restart gunicorn
#sudo systemctl status nginx

#!/bin/ba
sed -i 's/\[]/\["54.164.227.130"]/' /home/ubuntu/test-deploy/conf/settings.py

LOGFILE="/home/ubuntu/start_app.log"
echo "Starting application at $(date)" >> $LOGFILE

# Run Django management commands
cd /home/ubuntu/test-deploy
/home/ubuntu/venv/bin/python manage.py migrate >> $LOGFILE 2>&1
/home/ubuntu/venv/bin/python manage.py collectstatic --noinput >> $LOGFILE 2>&1

# Restart Gunicorn
echo "Restarting Gunicorn..." >> $LOGFILE
sudo service gunicorn restart >> $LOGFILE 2>&1

# Restart Nginx
echo "Restarting Nginx..." >> $LOGFILE
sudo service nginx restart >> $LOGFILE 2>&1

# Confirm completion
echo "Application started successfully at $(date)" >> $LOGFILE

