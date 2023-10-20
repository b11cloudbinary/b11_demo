# Configuration
$IIS_Service_Name = "W3SVC"
$IIS_Admin_Service_Name = "IISADMIN"
$URL_To_Check = "http://localhost"

# Check if IIS services are running
$W3SVC_Status = Get-Service -Name $IIS_Service_Name | Select-Object -ExpandProperty Status
$IISADMIN_Status = Get-Service -Name $IIS_Admin_Service_Name | Select-Object -ExpandProperty Status

# Check if default website is responding
try {
    $HTTP_Response = Invoke-WebRequest -Uri $URL_To_Check -TimeoutSec 5 -UseBasicParsing
    $Website_Status = $HTTP_Response.StatusCode
} catch {
    $Website_Status = $_.Exception.Response.StatusCode.Value__
}

if ($W3SVC_Status -ne "Running" -or $IISADMIN_Status -ne "Running" -or $Website_Status -ne 200) {
    Write-Output "IIS services or default website are not responding properly! Attempting to restart..."

    # Restarting the IIS services
    Restart-Service -Name $IIS_Service_Name -Force
    Restart-Service -Name $IIS_Admin_Service_Name -Force
    Write-Output "IIS services restarted!"

    # Send notification (this is just a console output, but can be replaced with a mail command or other notification methods)
    Write-Output "Notification: IIS services or default website were not responding properly, but have been restarted!"
}
