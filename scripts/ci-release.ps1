Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
#------------------------------

Import-Module '.\modules\versioning.psm1'
Import-Module '.\modules\changelog.psm1'
Import-Module '.\modules\git.psm1'

$version = $env:release_version
$description = $env:release_description

# Update AssembyInfo
$assemblyInfoPath = '..\src\ShortName\Properties\AssemblyInfo.cs'
Update-AssemblyInfo $assemblyInfoPath $version -Verbose

# Update CHANGELOG.md
$changelogPath = '..\CHANGELOG.md'
Update-Changelog $changelogPath $version $description -Verbose

# Build
# Test
# Create nuget-package in '..\Release' folder
Import-Module '.\PrepareRelease.ps1'

# Git checkout master
Invoke-Git ('checkout', 'master')

# Git add changes
Invoke-Git ('add', $assemblyInfoPath) -Verbose
Invoke-Git ('add', $changelogPath) -Verbose

# Git commit and push
Invoke-GitCommit "Version $version" -Verbose
Invoke-Git ('push', 'origin') -Verbose

# Git tag and push
$buildUrl = $env:BUILD_URL
Invoke-GitTag "Version '$version'. Build url '$buildUrl'." "v$version" -Verbose
Invoke-Git ('push', 'origin', "v$version") -Verbose

# Push nuget-package
$package = Join-Path $releaseDir '*.nupkg'
#Invoke-NuGetPush $package -Verbose

# Create github release
