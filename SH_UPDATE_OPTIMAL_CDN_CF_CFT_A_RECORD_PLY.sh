#!/bin/bash
sed -i 's/\r//' /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log
a_1_1=$(tail -11 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_1_2=$(tail -10 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_1_3=$(tail -9 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_1_4=$(tail -8 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_1_5=$(tail -7 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)

a_2_1=$(tail -5 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_2_2=$(tail -4 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_2_3=$(tail -3 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_2_4=$(tail -2 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log | head -1)
a_2_5=$(tail -1 /root/LOG/LOG_OPTIMAL_CDN_CF_CFT_IPv4_PLY_ACCU.log)

date >> /root/LOG/LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log

if [[ ! $a_2_5 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then
        echo "INCORRECT IPv4 FORMAT, EXIT." | tee -a /root/LOG/LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log
        exit
fi

id_1_1="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_1_2="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_1_3="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_1_4="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_1_5="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

id_2_1="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_2_2="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_2_3="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_2_4="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
id_2_5="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

n_1_1="cf1"
n_1_2="cf2"
n_1_3="cf3"
n_1_4="cf4"
n_1_5="cf5"

n_2_1="cft1"
n_2_2="cft2"
n_2_3="cft3"
n_2_4="cft4"
n_2_5="cft5"

global_key="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
Email="xxx@fuckccp.com"
ZoneID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

for x in $(seq 2); do

for y in $(seq 5); do

eval id=\${id_${x}_${y}}
eval n=\${n_${x}_${y}}
eval ipv4=\${a_${x}_${y}}

generate_post_data1()
{
  cat <<EOF
{
  "type":"A",
  "name":"${n}.xxxx.com",
  "content":"$ipv4",
  "ttl":1,
  "proxied":false
}
EOF
}

        i=1
        while true
        do
        curl --connect-timeout 3 -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZoneID/dns_records/$id" -H "Content-Type: application/json" -H "X-Auth-Email: $Email" -H  "X-Auth-Key: $global_key" --data "$(generate_post_data1)"  &>/dev/null
        if [[ $? -eq 0 ]]
          then
            echo "$i TRIES SUCCESSFULLY UPDATED CF A RECORD $ipv4 FOR ${n}." >> /root/LOG/LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log
            break
          else
            if [[ $i -gt 10 ]]
              then
                echo "ALL $i TRIES FAILED UPDATEING CF A RECORD $ipv4 FOR ${n}, GAVE UP." >> /root/LOG/LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log
                exit
              else
                echo "$i TRIES FAILED UPDATEING CF A RECORD $ipv4 FOR ${n}, TRY AGAIN 10S LATER." >> /root/LOG/LOG_UPDATE_OPTIMAL_CDN_A_RECORD.log
                i=$((i+1))
                sleep 10s
            fi
        fi
        done
done

done