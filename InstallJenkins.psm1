function InstallJenkins
{
    param (
        [string]$JENKINS_HOME
    )

    [System.Environment]::SetEnvironmentVariable('JENKINS_HOME',"$JENKINS_HOME",'Machine')
    
    Write-Host "JENKINS_HOME: " ([System.Environment]::GetEnvironmentVariable('JENKINS_HOME'))
    
    if(!((Test-Path "C:\Temp\Jenkins\install.log") -and (((Get-Content "C:\Temp\Jenkins\install.log").GetEnumerator()).contains("Installation success or error status: 0.") -eq $true)))
    {
        Write-Host "Installing Jenkins"
        . C:\Temp\Jenkins\jenkins.msi /quiet /norestart /log C:\Temp\Jenkins\install.log JENKINSDIR="${env:JENKINS_HOME}"
        Start-Sleep 10
        while(Get-Process -Name msiexec -ErrorAction SilentlyContinue)
        {
            Write-Host "Waiting for Jenkins Installation to complete..."
            Start-Sleep 10
        }
    }

    Write-Host "Admin Password:"
    
    if ( ((Get-Content "${env:JENKINS_HOME}\users\users.xml").GetEnumerator()).contains("admin") -eq $true)
    {
        Get-Content "${env:JENKINS_HOME}\secrets\initialAdminPassword"
    }
}