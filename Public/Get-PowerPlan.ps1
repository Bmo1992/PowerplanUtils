Function Get-PowerPlan
{
    <#
        .SYNOPSIS
          Get the information of an active or non active power plan. 
        
        .DESCRIPTION
          Calls to the cim instance 'root\cimv2\power' via the Win32_PowerPlan class to gather the ID of the systems power plans.
         
        .PARAMETER Active
          Specify whether to choose the active or non-active power plan. 
          
        .EXAMPLE
          Get-PowerPlan -Active:$True
          
          Returns the information of the active power plan.
          
        .EXAMPLE
          Get-PowerPlan -Active:$False
          
          Returns the information of the non-active power plan. 
        
        .NOTES
          NAME    : Get-PowerPlan
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
        [bool]$Active
    )

    if($Active)
    {
        Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerPlan | Where{ `
            $_.IsActive -eq $True
        }
    }
    else
    {
        Get-CimInstance -Namespace "root\cimv2\power" -ClassName Win32_PowerPlan | Where{ `
            $_.IsActive -eq $False
        }
    }
}

Export-ModuleMember -Function Get-PowerPlan