###############################################################
# Name:         GetDllVersion.ps1
# Description:  Prints out DLL version
# Usage:        GetDllVersion.ps1 <path to DLL> [<version suffix>]
# Author:       Anton Khitrenovich, Jan 2014
# Usage:		powershell -ExecutionPolicy bypass -File GetDllVersion.ps1 "C:\Program Files\Java\jre7\bin\java.dll"
###############################################################
param(
    [string]$DLL,
    [string]$SuffixOverride
)

function IsAllowedInVersion ($VersionTokenCandidate) {
    # Version tokens should be nonempty/nonnull and contain only digits
    return !([string]::IsNullOrEmpty($VersionTokenCandidate)) -and $VersionTokenCandidate -match '^\d+$'
}

$Separators = ".- "

if (!(Test-Path $DLL)) {
    throw "File '{0}' does not exist" -f $DLL
}
 
try {
    $Major, $Minor, $Patch, $Suffix, $Junk = (Get-Item "$DLL").VersionInfo.FileVersion.Split($Separators)
} catch {
    throw "Failed to get DLL file version: {0}." -f $_
}

if (IsAllowedInVersion($SuffixOverride)){
    $VersionTokens = ($Major, $Minor, $Patch, $SuffixOverride) | Where { IsAllowedInVersion $_ }
} else {
    $VersionTokens = ($Major, $Minor, $Patch, $Suffix) | Where { IsAllowedInVersion $_ }
}

$Version = [string]::Join('.', $VersionTokens)
 
return "Version=$Version"
