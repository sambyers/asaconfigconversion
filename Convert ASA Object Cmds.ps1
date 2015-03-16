# This script converts object commands from Cisco ASA 8.2 configuration to 8.3+ object commands.
# Only feed it name commands, it will not parse an entire configuration file correctly.

$txt_file = "<your text file of object names here>"

foreach ($command in Get-Content $txt_file ) {
    $split_command = $command.split(" ")
    $command_1 = $split_command[0].Replace("name","object network")
    $command_2 = $split_command[1]
    $command_3 = $split_command[2]
    
    if ($split_command.Contains("description")) {
        write-host $command_1 $command_3
        write-host "host" $command_2
        write-host $split_command[3] $split_command[4..20]

    }
    else {
        write-host $command_1 $command_3
        write-host "host" $command_2 
    }
}