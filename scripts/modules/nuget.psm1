Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
#------------------------------

Function Invoke-NuGetPack()
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$packTarget,
        
        [Parameter(Mandatory=$True)]
        [string]$configuration,

        [string]$outputDirectory = '.'
    )
    
    $arguments = @(
        'pack'
        $packTarget
        '-IncludeReferencedProjects'
        '-Properties'
        "Configuration=$configuration"
        '-OutputDirectory'
        $outputDirectory
    )

    Write-Output '---> Run NuGet pack.'
    Invoke-NuGet $arguments
    Write-Output '---> NuGet pack succeeded.'
}

Function Invoke-NuGetPush()
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$package
    )
    
    $arguments = @(
        'push'
        $package
    )

    Write-Output '---> Run NuGet pack.'
    Invoke-NuGet $arguments
    Write-Output '---> NuGet pack succeeded.'
}

Function Invoke-NuGet($arguments)
{
    $nugetPath = ''
    if ($env:NUGET)
    {
        $nugetPath = $env:NUGET
    }
    elseif (Get-Command 'nuget.exe' -ErrorAction SilentlyContinue) 
    {
        $nugetPath = 'nuget'
    }
    else
    {
        Write-Verbose 'Environment variable NUGET not set'
        Write-Verbose 'Unable to find nuget.exe in your PATH'
        throw 'Unable to find path to nuget.exe. See more with -Verbose'
    }
    
    Write-Verbose "NuGet path: $nugetPath"
    Write-Verbose "NuGet arguments: $arguments"
    & $nugetPath $arguments
    if ($LASTEXITCODE -ne 0)
    {
        Write-Output "NuGet failed with exit code $LASTEXITCODE"
        Exit $LASTEXITCODE
    }
}

Export-ModuleMember -Function Invoke-NuGetPack, Invoke-NuGetPush
