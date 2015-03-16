# This script converts object commands from Cisco ASA 8.2 configuration to 8.3+ object commands.
# Only feed it object groups commands, it will not parse an entire configuration file correctly.
# author: samwbyers@gmail.com

$txt_file = "<your text file of object names here>"

foreach ($command in Get-Content $txt_file ) {
    $split_command = $command.split(" ")
    if ($split_command[1].Contains("host")) {
        if ($split_command[2] -match '[a-z]') {
            write-host $split_command[0] "object" $split_command[2] # $split_command[3..8]
        }
        else { 
            write-host $split_command[0] "object" $split_command[2..5] }

    }
    # Check to see if the command is a network-object and has a name and has a subnet mask at the end. Add object between network-object and the name and drop the subnet mask.
    # The subnet mask is contained in the network object declaration itself, not the object-group.
    elseif ($split_command[0].Contains("network-object") -and $split_command[1] -match '[a-z]' -and $split_command[2].Contains("255")) {
        write-host $split_command[0] "object" $split_command[1]
    }
    # Add 'destination' into the command for all service-objects 
    elseif ($split_command[0].Contains("service-object") -and -not $split_command[1].Contains("icmp")) {
        write-host $split_command[0] $split_command[1] "destination" $split_command[2..8]
    }
    else { write-host $command }
}