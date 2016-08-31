<#  
.SYNOPSIS  
    Script to control CloudFlare    
.DESCRIPTION  
    
.NOTES  
    Author     : Chris Hudson  
    Requires   : PowerShell
	#System wide Modules %ProgramFiles%\WindowsPowerShell\Modules
	
.LINK  

    
	
.EXAMPLE  
	Import-Module Logging.psm1
	
#>  
# Params MUST BE FIRST THING IN SCRIPT

# ensure that you cannot reference things such as  uninitialized variables and non-existent properties of an object
# Set-StrictMode -Version Latest 

## Global Timer variables
$sw = [Diagnostics.Stopwatch]::StartNew()
#filter timestamp {"$(Get-Date -Format o): $_"}
Function Start_Timer()
{
$sw.Start();
Write_Log "Begin Script"
}

Function End_Timer()
{
## End Timers
$sw.Stop()
$duration = $sw.Elapsed.ToString("hh\:mm\:ss\,fff")
Write_Log "Duration: $duration" 
Write_Log "End Script"
}

Function Get-FunctionName { 
#scope is set to 2 since this is called from Write_Log and I want to get the calling function rather than just Write_Log (1)
    (Get-Variable MyInvocation -Scope 2).Value.MyCommand.Name;
}

Function Write_Log([string]$msg)
{
	$function = $(Get-FunctionName)
	$timestamp = $(Get-Date -Format o)
	Write-Output "$timestamp Message=[$msg] Function=[$function] `r`n"
}


# export-modulemember -function Start_Timer
# export-modulemember -function End_Timer
# export-modulemember -function Write_Log
