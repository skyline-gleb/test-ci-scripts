Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
#------------------------------

$configuration = 'Release'
$solutionDir = Join-Path $PSScriptRoot "../src"
$solution = Join-Path $solutionDir 'ShortName.sln'
$project = Join-Path $solutionDir 'ShortName\ShortName.csproj'
$testFile = Join-Path $solutionDir "ShortName.Tests\bin\$configuration\ShortName.Tests.dll"
$releaseDir = Join-Path $PSScriptRoot '../Release'
$assemblyInfoPath = Join-Path $solutionDir 'ShortName\Properties\AssemblyInfo.cs'
$changelogPath = Join-Path $PSScriptRoot '..\CHANGELOG.md'
$nuspecPath = Join-Path $solutionDir 'ShortName\ShortName.nuspec'
$githubProjectName = 'test-ci-scripts'

$msbuildProperties = @{
    'Configuration' = $configuration
}
