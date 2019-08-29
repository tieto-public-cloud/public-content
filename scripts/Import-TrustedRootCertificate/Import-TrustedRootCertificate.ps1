Param(
    [Parameter(Mandatory = $false)]
    [string]
    $BaseUri = "https://sslinspectionstorage2908.blob.core.windows.net/certs", # Url of the storage account container

    [Parameter(Mandatory = $false)]
    [string]
    $CertName = "CACert.crt" # Root public certificate file name 
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
