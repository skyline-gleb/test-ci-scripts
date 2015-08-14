Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
#------------------------------

$configuration = 'Release'
$solutionDir = Join-Path $PSScriptRoot "../src"
$solution = Join-Path $solutionDir 'ShortName.sln'
$project = Join-Path $solutionDir 'ShortName\ShortName.csproj'
$testFile = Join-Path $solutionDir "ShortName.Tests\bin\$configuration\ShortName.Tests.dll"
$releaseDir = Join-Path $PSScriptRoot '../Release'
$assemblyInfoPath = '..\src\ShortName\Properties\AssemblyInfo.cs'
$changelogPath = '..\CHANGELOG.md'

$msbuildProperties = @{
    'Configuration' = $configuration
}
