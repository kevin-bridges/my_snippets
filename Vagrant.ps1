<#
.SYNOPSIS
Quick way to halt all running Vagrant Boxes. 

.DESCRIPTION
halts all running vagrant boxes, found in a directory containing a VagrantFile

.PARAMETER VagrantDirectoryRoot
Root directory for searching for vagrantfiles. This is

.PARAMETER forceShutdown
Forcefully shutsdown the vagrantbox/image adds the --force flag

.EXAMPLE
#Uses all default arguments
    Vagrant-HaltRunningBoxes

#Halts all vagrantboxes found in C:\Users\($env:UserName)\AppData\Roaming\Vagrantboxes
    Vagrant-HaltRunningBoxes -VagrantDirectoryRoot "$env:APPDATA\Vagrantboxes"

#Halts only specific boxes running in specific folder with the force flag
    Vagrant-HaltRunningBoxes "c\Vagrant\WebEnvironment\" $true
.NOTES
Chocolatey Information
    Installation Notes: https://chocolatey.org/install

    choco install vagrant #https://chocolatey.org/packages/vagrant

Vagrant information
    vagrant --help
    vagrant halt -h
#>
Function Vagrant-HaltRunningBoxes 
{
    [Cmdletbinding( )]
    Param ( [string] $VagrantDirectoryRoot = "c:\vagrant\",
            [bool] $forceShutdown = $false )

    $VagrantFlags = ""
    $VagrantVersion = (vagrant --version)

    if(!$?)
    {
        return "Error Running Vagrant. Check vagrant Installation"
    }

    if (isverbose)
    {
        $VagrantVersion
        $VagrantFlags += "--verbose "
    }

    if ( $forceShutdown )
    {
        $VagrantFlags += "--force "
    }
    
    $( Get-ChildItem $VagrantDirectoryRoot -Filter "vagrantfile" -Recurse ).Directory | ForEach-Object {

        Push-Location $_ -Verbose:(isVerbose)
        $Boxstatus = (vagrant status)

        if ($false -eq ([string]::IsNullOrWhiteSpace( $Boxstatus ) ) )
        {
            $Boxstatus | ForEach-Object { Write-Verbose $_ }

            $Boxstatus | ForEach-Object { 
                #Example matching vagrant status output
                #WindowsBox                        running (virtualbox)
                if ( $_ -match ' running \(' ) 
                { 
                    $VagrantBox = $($_.split(" ")[0]).trim( )
                    Write-verbose "Halting running vagrant image [$VagrantBox]";
                    vagrant halt $VagrantBox $VagrantFlags.Trim( )
                } 
            }
        }
    
        Pop-Location -Verbose:(isVerbose)
    }
}
