Function Set-PowerPlanActionedSetting
{
    <#
        .SYNOPSIS
          Set the value of a specific power setting with a particular action. 
        
        .DESCRIPTION
          Set actioned settings, those with options like Do Nothing, Sleep, Hibernate, and Shut down, to the desired setting level.  Required
          parameters include the PowerSettingAction and SettingObject are required in order to set these settings.
        
        .PARAMETER PowerSettingAction
          Specify the specific action you'd like the power setting to take. The only values accepted are "DoNothing",  
          "Sleep", "Hibernate", and "ShutDown" which can all be tab completed. This parameter is required.
        
        .PARAMETER SettingObject
          Pass the setting object directly to the script. To retrieve this option Get-PowerPlanSettingValue function.

        .Example
          Set-PowerPlanActionedSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
          -InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Low battery action")) -PowerSettingAction DoNothing

          This will set the Low battery action setting of the currently active power plan to the action "DoNothing"
 
        .NOTES
          NAME    : Set-PowerPlanActionedSetting
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 17, 2019 
          META    : There might be a smarter way to do this but I'm not a smart man.
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            Mandatory=$True
        )]
        [ValidateSet(
            "DoNothing",
            "Sleep",
            "Hibernate",
            "ShutDown"
        )]
        [string]$PowerSettingAction,
        [object]$SettingObject
    ) 

    if($PowerSettingAction -eq "DoNothing")
    {
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = 0}
        $SettingObject
    }
    elseif($PowerSettingAction -eq "Sleep")
    {
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = 1}
        $SettingObject
    }
    elseif($PowerSettingAction -eq "Hibernate")
    {
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = 2}
        $SettingObject
    }
    elseif($PowerSettingAction -eq "ShutDown")
    {
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = 3}
        $SettingObject
    }
    else
    {
        Throw "$PowerSettingAction is not a valid setting, please choose from the accepted list."
    }
}

Export-ModuleMember -Function Set-PowerPlanActionedSetting