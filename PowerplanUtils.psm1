<#
    .SYNOPSIS
      PowerplanUtils is a PowerShell module to interact with Windows power plans and their associated settings.
      These are normally access through the control panel under power options.
      
    .NOTES      
      NAME    : PowerplanUtils 
      AUTHOR  : BMO
      EMAIL   : brandonseahorse@gmail.com
      GITHUB  : github.com/Bmo1992
      CREATED : September 18, 2019
#>

$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)

ForEach ($function in $Public)
{
    Try
    {
        . $function.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($function.fullname): $_"
    }
}