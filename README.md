# Automating AWS Architecture for amazing-php-app

The premise is to run stateless app servers running behind
an ELB serving traffic with autoscaling enabled.

This automation creates following services in AWS
1. VPC - 1
2. Subnets - 2
3. Security Group - 1
4. Auto Scaling Group - 1
5. Elastic Load Balancer - 1
6. EC2-Instances - 2
7. Route-table - 1
8. Internet gateway - 1

After you run `terraform apply` on this configuration, it will
automatically output the DNS address of the ELB. After your instance
registers, this should respond with the default nginx web page.

## Steps to set up:

Create the ssh rsa key in the project directory with name `glofox`

```
ssh-keygen -t rsa
```

Verify the resources terraform creates:

```
terraform plan -out out.tfplan
```

Apply the changes to build the infrastructure:
```
terraform apply out.tfplan
```


## To deploy app to AWS
Update the hosts file with the ec2-instance ip-address (TODO: Can be set to auto-discovery)
Update the path of the private key
Run the deploy script
```
sh deploy.sh
```


## To destroy the infrastructure
```
terraform destroy
```
