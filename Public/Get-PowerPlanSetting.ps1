Function Get-PowerPlanSetting
{
    <#
        .SYNOPSIS
          Retrieve information about a specific power plan setting. 
          
        .DESCRIPTION
          Make a call via cim to "root\cimv2\power" using the Win32_PowerSetting class to pull the information for a specific power plan setting.
        
        .PARAMETER Name
          Specify the name of the power setting to retrieve information about.  
        
        .EXAMPLE
          Get-PowerPlanSetting -Name "Low battery action". By default all power plan settings will output to stdout.
          
          Retrieves all information about the power setting named low battery action. Output should look like below:
            Caption        :
            Description    : Specify the action that your computer takes when battery capacity reaches the low level.
            ElementName    : Low battery action
            InstanceID     : Microsoft:PowerSetting\{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
            PSComputerName :
            
        .EXAMPLE
          Get-PowerPlanSetting
          
          Retrieves al information about all the power settings available on the computer in question.
        
        .NOTES
          NAME    : Get-PowerPlanSetting
          AUTHOR  : BMO
          EMAIL   : brandonseahorse@gmail.com
          GITHUB  : github.com/Bmo1992
          CREATED : September 17, 2019
    #>
    [CmdletBinding()]
    Param
    ( 
        [Parameter(
            Mandatory=$False
        )]
        [string[]]$Name
    )

    if($Name)
    {
        ForEach($Element in $Name)
        {
            # Try catch not working as if there's no match the try block continues silently 
            Try
            {
                Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSetting | Where{ `
                    $_.ElementName -eq "$Element"
                }       
            }
            Catch
            {
                Throw "Couldn't retrieve a powerplan setting for $Element"
            }
        }
    }
    else
    {
        Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerSetting
    }
}