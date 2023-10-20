#!/bin/bash

# Configuration
HTTPD_SERVICE="httpd" # Service name may vary based on your OS. It could be 'apache2' for some distributions.
URL_TO_CHECK="http://localhost" # URL to check the HTTP response.

# Check if httpd process is running
pgrep ${HTTPD_SERVICE} > /dev/null 2>&1
PROCESS_STATUS=$?

# Check if server is responding
curl --output /dev/null --silent --head --fail ${URL_TO_CHECK}
HTTP_STATUS=$?

if [ ${PROCESS_STATUS} -ne 0 ] || [ ${HTTP_STATUS} -ne 0 ]; then
    echo "Httpd service is down or not responding! Attempting to restart..."

    # Restarting the service
    sudo systemctl restart ${HTTPD_SERVICE}
    echo "${HTTPD_SERVICE} restarted!"

    # Send notification (this is just an echo, but can be replaced with mail command, etc.)
    echo "Notification: ${HTTPD_SERVICE} was down, but has been restarted!"
fi
