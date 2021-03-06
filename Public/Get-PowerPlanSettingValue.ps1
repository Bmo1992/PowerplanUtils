Function Get-PowerPlanSettingValue
{
    <#
        .SYNOPSIS
          Get the information of a specific power plan's setting.  
        
        .DESCRIPTION
          Calls to the cim instance 'root\cimv2\power' via the Win32_PowerSettingDataIndex class to gather specific information
          for a setting of a power plan.
         
        .PARAMETER InputPowerPlanId
          Specify the ID of the power plan you'd like to make changes to. This is required.
          
        .PARAMETER InputPowerPlanSettingId
          Specify the ID of the setting you'd like to make changes to. To get this value use the Get-PowerPlanSetting
          function. 
          This is required.
          
        .PARAMETER OnBattery
          Specify whether or not to set the value of the OnBattery power setting. By default the "plugged in" value is set.
          If this value is set to true then you will retrieve the power action for the "On battery" value.  "Plugged in" 
          uses DC input wheras "On battery" utilizes AC input.  
          
        .EXAMPLE
          Get-PowerPlanSettingValue -InputPowerPlanId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -InputPowerPlanSettingId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
          
          Returns the settings of the power plan with a value of xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx and the setting with an ID of xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        
        .NOTES
          NAME    : Get-PowerPlanSettingValue
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 17, 2019
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [string]$InputPowerPlanId,
        [string]$InputPowerPlanSettingId,
        [bool]$OnBattery
    )
    
    # If the Battery argument is specified then it'll set the DC (on battery) value of the power setting. Else set the regular AC 
    # (plugged in) value of the power setting.
    if($OnBattery)
    {
        Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSettingDataIndex `
        -Filter "InstanceID like '%$InputPowerPlanId%DC%$InputPowerPlanSettingId%'"
    }
    else
    {
        Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSettingDataIndex `
        -Filter "InstanceID like '%$InputPowerPlanId%AC%$InputPowerPlanSettingId%'"
    }
} 

Export-ModuleMember -Function Get-PowerPlanSettingValue