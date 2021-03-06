# PowerplanUtils

PowerplanUtils is a PowerShell module to interact with the Windows power plan settings.

## Table of Contents
- [Installation](#installation)
- [Overview](#Overview)
- [Usage](#usage)
  - [Commands](#commands)
    - [Get-PowerPlan](#Get-PowerPlan)
    - [Get-PowerPlanId](#Get-PowerPlanId)
    - [Get-PowerPlanSetting](#Get-PowerPlanSetting)
    - [Get-PowerPlanSettingId](#Get-PowerPlanSettingId)
    - [Get-PowerPlanSettingDefinition](#Get-PowerPlanSettingDefinition)
    - [Get-PowerPlanSettingRange](#Get-PowerPlanSettingRange)
    - [Get-PowerPlanSettingValue](#Get-PowerPlanSettingValue)
    - [Set-PowerPlanActionedSetting](#Set-PowerPlanActionedSetting)
    - [Set-PowerPlanTimedSetting](#Set-PowerPlanTimedSetting)
    - [Set-PowerPlanPercentSetting](#Set-PowerPlanPercentSetting)

## Installation

Install directly from the PowerShell Gallery by running the following:
```powershell
Install-Module -Name PowerplanUtils
```
Once installed you can bring the module into your session by importing it:
```powershell
Import-Module -Name PowerplanUtils
```

## Overview

PowerplanUtils is a PowerShell module designed to retrieve and edit power plans and their settings in a way native to PS. Previously this was accomplished through powercfg.exe or by manually configuring the options in the control panel power options.

## Usage

### Commands

The following commands are available:

#### Get-PowerPlan

Retrieve the power plans on the current computer. Use the -Active and specify true to only pull the active powerplan.  The Active argument is required.

```powershell
Get-PowerPlan -Active:$True
```
```text
Caption        : 
Description    : Automatically balances performance with energy consumption on capable hardware.
ElementName    : Dell
InstanceID     : Microsoft:PowerPlan\{555555555-5555-5555-5555-555555555555}
IsActive       : True
PSComputerName :
```

```powershell
Get-PowerPlan -Active:$False
```
```text
Caption        : 
Description    : Automatically balances performance with energy consumption on capable hardware.
ElementName    : Balanced
InstanceID     : Microsoft:PowerPlan\{44444444-4444-4444-4444-444444444444}
IsActive       : False
PSComputerName :
```

#### Get-PowerPlanId

Retrieve the ID of a PowerPlan on the current computer.  Use the -Active argument in the same was Get-PowerPlan (see above for more details). This pulls only
the ID which is required for many of the other Cmdlets in this module.

```powershell
Get-PowerPlanId -Active:$True
```
```text
{555555555-5555-5555-5555-555555555555}
```

#### Get-PowerPlanSetting

Retrieve the caption, description, elementname, and instanceId of a specific power setting available on the computer or all power settings by default.

```powershell        
Get-PowerPlanSetting -Name "Low battery action"
```
```text
Caption        :
Description    : Specify the action that your computer takes when battery capacity reaches the low level.
ElementName    : Low battery action
InstanceID     : Microsoft:PowerSetting\{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
PSComputerName :
```
#### Get-PowerPlanSettingId

Retrieve the ID of a specific PowerPlan setting on the current computer.  Use the -Name argument to specify the name of the specific power setting to retrieve
the ID which is required for many of the other Cmdlets in this module.

```powershell
Get-PowerPlanSettingId -Name "Low battery action"
```
```text
{555555555-5555-5555-5555-555555555555}
```

#### Get-PowerPlanSettingDefinition

Retrieve the values that a specific power setting can be set to. Use the -PowerSettingID argument and pass to it the ID of the power setting in question.
The PowerSettingID is a required value and can be retrieved with the Get-PowerPlanSettingId function.

This only retrieves the values if the power setting has a specific action setting like "Do nothing", "Sleep", or "Shut down"

```powershell
Get-PowerPlanSettingDefinition -PowerSettingID $(Get-PowerPlanSettingId -Name "Low battery action")
```
```text
ElementName SettingValue
----------- ------------
Do nothing
Sleep
Hibernate
Shut down
```

#### Get-PowerPlanSettingRange

Retrieve the values that a specific power setting can be set to. Use the -PowerSettingID argument and pass to it the ID of the power setting in question.
The PowerSettingID is a required value and can be retrieved with the Get-PowerPlanSettingId function.

This only retrieves the values if the power setting has a specific range value expressed by an integer either in minutes or as a 
percentage (Ex: can be set between 1-100% such as citrical battery level or minutes such as turn display off after)

```powershell
Get-PowerPlanSettingRange -PowerSettingID $(Get-PowerPlanSettingId -Name "Turn off display after")
```
```text
ElementName    SettingValue
-----------    ------------
ValueMax         4294967295
ValueMin                  0
ValueIncrement            1
```

#### Get-PowerPlanSettingValue

This returned the current value that a specific power plan setting is set to. Required values include the ID of the power plan
and the power setting in question. Use the OnBattery argument to specify whether or not to pull the "on battery" value of the
power setting in question.

The value returned from this is required later for any of the Set-PowerPlan* functions. Keep in mind this will return the raw
values as returned by CIM.

```powershell
Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) -InputPowerPlanSettingId `
$(Get-PowerPlanSettingId -Name "Low battery action")
```
```text
Caption           :
Description       :
ElementName       :
InstanceID        : Microsoft:PowerSettingDataIndex\{381b4222-f694-41f0-9685-ff5bb260df2e}\DC\{d8742dcb-3e6a-4b3c-b3fe-
                    374623cdcf06}
SettingIndexValue : 0
PSComputerName    :
```
```powershell
Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) -InputPowerPlanSettingId `
$(Get-PowerPlanSettingId -Name "Low battery action") -OnBattery:$True
```
```text
Caption           :
Description       :
ElementName       :
InstanceID        : Microsoft:PowerSettingDataIndex\{381b4222-f694-41f0-9685-ff5bb260df2e}\AC\{d8742dcb-3e6a-4b3c-b3fe-
                    374623cdcf06}
SettingIndexValue : 0
PSComputerName    :
```

#### Set-PowerPlanActionedSetting

Set actioned settings, those with options like Do Nothing, Sleep, Hibernate, and Shut down, to the desired setting level.  Required
parameters include the PowerSettingAction and SettingObject are required in order to set these settings. The setting object is 
returned with it's newly set value.

The setting object can be pulled with the Get-PowerPlanSettingValue function. See above for information on how to use that function.

```powershell
Set-PowerPlanActionedSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) ` -InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Low battery action")) -PowerSettingAction DoNothing
```
```text
Caption           :
Description       :
ElementName       :
InstanceID        : Microsoft:PowerSettingDataIndex\{381b4222-f694-41f0-9685-ff5bb260df2e}\DC\{d8742dcb-3e6a-4b3c-b3fe-374623cdcf06}
SettingIndexValue : 0
PSComputerName    :
```

#### Set-PowerPlanTimedSetting

Set the time, in minutes, of a power setting that uses time as it's value. (EX: the "Turn off hard disk after" setting requires a value of minutes starting with 1.  The Never boolean argurment sets this value to 0 which means to never turn the hard disk off after any period of time.
The setting object is returned with it's newly set value.

```powershell
Set-PowerPlanTimedSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
-InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Turn off hard disk after")) -PowerSettingMinutes 60
```
```text
Caption           :
Description       :
ElementName       :
InstanceID        : Microsoft:PowerSettingDataIndex\{381b4222-f694-41f0-9685-ff5bb260df2e}\DC\{6738e2c4-e8a5-4a42-b16a-e040e769756e}
SettingIndexValue : 3600
PSComputerName    :
```

#### Set-PowerPlanPercentSetting

Set the percentage, between 1 and 100, of a power setting that uses a percentage as it's value. (EX: the "Critical Battery Level")
Setting requires a value starting with 1 and up to 100. The setting object is returned with it's newly set value.

```powershell
Set-PowerPlanPercentSetting -SettingObject $(Get-PowerPlanSettingValue -InputPowerPlanId $(Get-PowerPlanId -Active:$True) `
-InputPowerPlanSettingId $(Get-PowerPlanSettingId -Name "Critical battery level")) -PowerSettingPercent 5
```
```text
Caption           :
Description       :
ElementName       :
InstanceID        : Microsoft:PowerSettingDataIndex\{381b4222-f694-41f0-9685-ff5bb260df2e}\DC\{9a66d8d7-4ff7-4ef9-b5a2-5a326ca2a469}
SettingIndexValue : 5
PSComputerName    :
```