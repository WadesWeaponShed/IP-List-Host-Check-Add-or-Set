This is a custom script written for a rather unique use case. The script will take a list of IPv4 Addresses in 'ip.txt' and parse them one line at a time searching the object database for that IP address. If a host exist it will add it to the group specified. If the host does not exist it will create a new host and add it to the group specified.  

## How to use ##
 - cp scripts over to mgmt station (this script is intended to run directly on the mgmt station)
  - I highly recommend that you do this in it's own folder
 - execute ./ip_list_host_check.sh
    - Follow the prompts
    - Output will be in a txt file host_set.txt
      - this file is already executable and will contain all of the mgmt_cli to make the changes simply execute './host_set.txt'

#### NOTE: The script is pre-built to use a group called 'auto-group' if you want to change the name just 'vi ip_list_host_check.sh' and do :%s/auto-group/NEW-GROUP-NAME/g ####
#### NOTE 2: The script has a generic name for new host objects 'Host-$IP-Address' (Host-5.5.5.5) this can be easily changed as long as it is uniqe on each host. You can change this after the fact or in the script ####
