# Based on this post: https://repost.aws/knowledge-center/rds-connect-using-bastion-host-linux

# ssh -i <identity_file> -f -l <bastion-host-username> -L 
# <local-port-you-connect-to>:<rds-endpoint>:<rds:listening-port>
# <bastion-host-public-ip> -v

# Option 1
# ssh -i identity file -f -l ubuntu -L 5433:"${rds_endpoint}" "${bastion_pub_ip}" -v

# Option 2
# ssh -i "Private_key.pem" -f -N -L 5433:RDS_Instance_Endpoint:5432 ec2-user@EC2-Instance_Endpoint -v

ssh -i your-pem-key.pem -f -N -L 5433:terraform-2023.aaxxZZsscc.eu-west-1.rds.amazonaws.com:5432 <ec2User>@12.345.678.999 -v
