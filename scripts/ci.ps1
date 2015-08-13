Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
#------------------------------

Import-Module '.\modules\msbuild.psm1'
Import-Module '.\modules\nunit.psm1'

$configuration = 'Release'
$solutionDir = Join-Path $PSScriptRoot "../src"
$solution = Join-Path $solutionDir 'ShortName.sln'
$testFile = Join-Path $solutionDir "ShortName.Tests\bin\$configuration\ShortName.Tests.dll"

$msbuildProperties = @{
    'Configuration' = $configuration
}

Invoke-MSBuild $solution $msbuildProperties -Verbose
Invoke-NUnit $testFile -Verbose
