# This script is used to create the prompt for the zsh shell.


# Get the Local IP of the machine.
function getLocalIP() {
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}

# Get the Public IP of the machine. Waits for the response for atmost 1 sec.
function getCurrentTime() {
    date "+%H:%M:%S"
}

function prompt() {
    # Constants - Change these values as needed.
    diskBlock='/dev/disk1s1'
    
    # Colors - Change the colors as needed.
    headerColor='\033[1;31m'
    headingColor='\033[1;37m'
    noColor='\033[0m'

    # Prints the System Information.
    echo " ${bold}${headingColor}System Details: ${noColor} ${notBold}"
    echo "\t${headerColor}Hostname:\t ${noColor} `whoami`"
    echo "\t${headerColor}Storage used:\t ${noColor} `df -h |  
        grep ${diskBlock} | 
        grep -vi 'efi' | 
        awk '{print $5}'`"
    
    # Prints the Misc information.
    echo " ${bold}${headingColor}Other Information: ${noColor} ${notBold}"
    echo "\t${headerColor}Local IP:\t ${noColor} `getLocalIP`"
    echo "\t${headerColor}Local Time:\t ${noColor} `getCurrentTime`"
}

function setZle() {
    prompt
    zle reset-prompt
}


# So that clear still renders the prompt
zle -N setZle
bindkey '^l' setZle

# To render the prompt initially
prompt

