#!/bin/bash

IP=$(curl ifconfig.me --silent)

echo "MyIP: $IP"
echo "";

echo "Update DevxIgndev-EC2-VPN"
aws ec2 modify-security-group-rules \
    --profile reprisedigital \
    --group-id sg-042bddbd7ec6062e9 \
    --security-group-rules SecurityGroupRuleId=sgr-03cb183f47ffc7907,SecurityGroupRule="{Description='Iskandar',IpProtocol=udp,FromPort=1194,ToPort=1194,CidrIpv4=${IP}/32}"
echo "";

echo "Update RepriseDigital-LB"
aws ec2 modify-security-group-rules \
    --group-id sg-05c4b079a03e1e4bc \
    --security-group-rules SecurityGroupRuleId=sgr-0e341273a6979d091,SecurityGroupRule="{Description='Iskandar',IpProtocol=tcp,FromPort=22,ToPort=22,CidrIpv4=${IP}/32}"
echo "";

echo "Update RepriseDigital-SSH-SG"
aws ec2 modify-security-group-rules \
    --profile reprisedigital \
    --group-id sg-020378b30777875cc \
    --security-group-rules SecurityGroupRuleId=sgr-00d98ae4ea8e376b1,SecurityGroupRule="{Description='IPG - Iskandar',IpProtocol=tcp,FromPort=80,ToPort=80,CidrIpv4=${IP}/32}"
echo "";

#echo "Update i-sinar-SG-EC2"
#aws ec2 modify-security-group-rules \
#    --group-id sg-07539ae7c916d85da \
#    --security-group-rules SecurityGroupRuleId=sgr-02538183abc328abe,SecurityGroupRule="{Description='IPG - Iskandar',IpProtocol=tcp,FromPort=22,ToPort=22,CidrIpv4=${IP}/32}"
#aws ec2 modify-security-group-rules \
#    --group-id sg-07539ae7c916d85da \
#    --security-group-rules SecurityGroupRuleId=sgr-00632d90bb7f4b913,SecurityGroupRule="{Description='Allow http from Iskandar',IpProtocol=tcp,FromPort=80,ToPort=80,CidrIpv4=${IP}/32}"
#echo "";

echo "Completed"
