# This script is used to create the prompt for the zsh shell.


# Fetches the Local IP of the machine.
function getLocalIP() {
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}

# Fetches the Public IP of the machine.
function getPublicIP() {
    curl -s ifconfig.me
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
    
    # Prints the network information.
    echo " ${bold}${headingColor}Network Information: ${noColor} ${notBold}"
    echo "\t${headerColor}Local IP:\t ${noColor} `getLocalIP`"
    echo "\t${headerColor}Public IP:\t ${noColor} `getPublicIP`"
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

