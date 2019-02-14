printf "\nWhat is the IP address or Name of the Domain or SMS you want to check?\n"
read DOMAIN

total=$(mgmt_cli -r true -d $DOMAIN show objects type host --format json |jq '.total')
printf "There are $total Objects\n"

rm host_set.txt
printf "\nChecking For Existing Hosts\n"
for I in $(seq 0 500 $total)
do
  for line in $(cat ip.txt)
  do
    if [[ $(mgmt_cli -r true -d $DOMAIN show objects type host filter "$line" ip-only true offset $I limit 500  --format json |jq '.total') = 1 ]]
    then
        mgmt_cli -r true -d $DOMAIN show objects type host filter "$line" ip-only true offset $I limit 500  --format json | jq --raw-output '.objects[] | "mgmt_cli -s id.txt set host name " +.name + " groups auto-group"' >> host_set.txt
    elif [[ $(mgmt_cli -r true -d $DOMAIN show objects type host filter "$line" ip-only true offset $I limit 500  --format json |jq '.total') = 0 ]]; then
      printf "mgmt_cli -s id.txt add host name Host-$line ip-address $line groups auto-group\n" >> host_set.txt
    fi
  done
done
sed -i '1s/^/mgmt_cli -r true login > id.txt\n/' host_set.txt
echo "mgmt_cli -s id.txt publish" >> host_set.txt
echo "mgmt_cli -s id.txt logout" >> host_set.txt
chmod +x host_set.txt
echo "You can execute host_set.txt using ./host_set.txt"
