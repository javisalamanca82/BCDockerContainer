$containerName = '<containerName>'
$password = '<password>'                # should fulfil password requirements
$type = '<type>'                        # Type: onprem, sandobx
$imageName = '<imageName>'
$userName = '<userName>'

$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object pscredential $userName, $securePassword
$auth = 'UserPassword'
$artifactUrl = Get-BcArtifactUrl -type $type -country 'de' -select 'Latest'
New-BcContainer `
    -accept_eula `
    -containerName $containerName `
    -credential $credential `
    -auth $auth `
    -artifactUrl $artifactUrl `
    -imageName $imageName `
    -multitenant:$false `
    -assignPremiumPlan `
    -dns '8.8.8.8' `
    -memoryLimit 8G `
    -includeAL `
    -doNotExportObjectsToText `
    -vsixFile (Get-LatestAlLanguageExtensionUrl) `
    -updateHosts `
    -isolation hyperv
Setup-BcContainerTestUsers -containerName $containerName -Password $credential.Password -credential $credential
