#requires -version 2

<#
.SYNOPSIS

    Import Trusted Root Certificate

.DESCRIPTION

    This script imports a public certificate from public Azure Storage blob to the computer trusted root certification authorities

.PARAMETER BaseUri
    Url of the storage account container

.PARAMETER CertName
    Root public certificate file name

.INPUTS

None

.OUTPUTS

None


.NOTES

  Version:        1.0

  Author:         Ondrej Vaclavu

  Creation Date:  2019/08/29

.EXAMPLE

#>

Param(
    [Parameter(Mandatory = $true)]
    [string]
    $BaseUri, # Url of the storage account container

    [Parameter(Mandatory = $true)]
    [string]
    $CertName # Root public certificate file name 
)

# Script variables (do not modify)
$certUri = "$BaseUri/$CertName"
$tempFile = "$env:temp\$CertName"

# Download public certificate from storage account and save in temp location
Invoke-WebRequest -Uri $certUri -OutFile $tempFile

# Import certificate to the trusted root certificates
Import-Certificate -FilePath $tempFile -CertStoreLocation Cert:\LocalMachine\Root

# Remove temp file
Remove-Item $tempFile
