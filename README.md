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
    - [Get-PowerPlanSettingDefinition](#Get-PowerPlanSettingDefinition)
    - [Get-PowerPlanSettingRange](#Get-PowerPlanSettingRange)
    - [Get-PowerPlanSettingValue](#Get-PowerPlanSettingValue)
    - [Set-PowerPlanActionedSetting](#Set-PowerPlanActionedSetting)
    - [Set-PowerPlanSetting](#Set-PowerPlanSetting)
    - [Set-PowerPlanTimedSetting](#Set-PowerPlanTimedSetting)

## Installation

Installation Coming Soon

## Overview

Overview Coming Soon

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

#### Get-PowerPlanSettingDefinition
