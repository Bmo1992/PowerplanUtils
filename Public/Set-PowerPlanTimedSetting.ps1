Function Set-PowerPlanTimedSetting
{
    <#
        .SYNOPSIS
          Set the time, in minutes, of a power setting that uses time as it's value. (EX: the "Turn off hard disk after")
          Setting requires a value of minutes starting with 1.  The Never boolean argurment sets this value to 0 which means
          to never turn the hard disk off after any period of time.
        
        .DESCRIPTION
          Set the time, in minutes, of a power setting that uses time as it's value. (EX: the "Turn off hard disk after")
          Setting requires a value of minutes starting with 1.  The Never boolean argurment sets this value to 0 which means
          to never turn the hard disk off after any period of time.
        
        .PARAMETER PowerSettingMinutes
          Specify the timeout, in minutes, that you'd like to set the power setting to. 
        
        .PARAMETER SettingObject
          Specify the power setting object.  This can be passed to it directly with Get-PowerPlanSettingValue or by storing 
          the output object of Get-PowerPlanSettingValue in a variable.
        
        .PARAMETER Never
          Set this value to true if you want the power setting to never time out. Effectivly sets the value to 0. 
        
        .EXAMPLE
          Set-PowerPlanTimedSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
          -InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Turn off hard disk after")) -PowerSettingMinutes 60

          Set the hard disk to turn off after 60 minutes of inactivity.

        .EXAMPLE
          Set-PowerPlanTimedSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
          -InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Turn off hard disk after")) -Never:$True

          Set the hard disk to never turn off.
    
        .NOTES
          NAME    : Set-PowerPlanTimedSetting
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
        [object]$SettingObject,
        [Parameter(
            Mandatory=$False
        )]
        [string]$PowerSettingMinutes,
        [bool]$Never
    )
    
    if($Never)
    {
        # The math here isn't necessary. I'm just too lazy to remove the Mandatory = $True condition for my parameters.
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = ([int]$PowerSettingMinutes * 0)}
        $SettingObject
    }
    else
    {
        $SettingObject | Set-CimInstance -Property @{SettingIndexValue = ([int]$PowerSettingMinutes * 60)}
        $SettingObject
    }
}

Export-ModuleMember -Function Set-PowerPlanTimedSetting