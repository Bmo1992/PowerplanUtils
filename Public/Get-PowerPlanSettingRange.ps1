Function Get-PowerPlanSettingRange
{
    <#
        .SYNOPSIS
          Gets the accepted range of input values for a specific power setting.
        
        .DESCRIPTION
        
        .PARAMETER PowerSettingID
          Specify the InstanceID of each power setting.  Multiple InstanceID's can be passed via this parameter but at least one needs to be passed to the cmdlet.
          
        .EXAMPLE
          Get-PowerPlanSettingRange -PowerSettingID xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        
        .NOTES
          NAME    : Get-PowerPlanSettingRange
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 18, 2019 
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory = $True
        )]
        [string]$PowerSettingID
    )
    
    Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSettingDefinitionRangeData -Filter "InstanceID like '%$PowerSettingID%'" | Select `
    ElementName,SettingValue
}

Export-ModuleMember -Function Get-PowerPlanSettingRange