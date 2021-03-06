Function Get-PowerPlanSettingDefinition
{
    <#
        .SYNOPSIS
          Gets the accepted values for power plan settings with a specific definition. 
        
        .DESCRIPTION
        
        .PARAMETER PowerSettingID
          Specify the InstanceID of each power setting.  Multiple InstanceID's can be passed via this parameter but at least one needs to be passed to the cmdlet.
          
        .EXAMPLE
          Get-PowerPlanSettingDefinition -PowerSettingID xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        
        .NOTES
          NAME    : Get-PowerPlanSettingDefinition
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 17, 2019 
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory = $True
        )]
        [string]$PowerSettingID
    )
    
    Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSettingDefinitionPossibleValue -Filter "InstanceID like '%$PowerSettingID%'" | Select `
    ElementName,SettingValue
}

Export-ModuleMember -Function Get-PowerPlanSettingDefinition