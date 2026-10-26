# Phase 8: Infrastructure as Code (Terraform / OpenTofu)

Declarative provisioning of a multi-tier cloud topology using OpenTofu against a local AWS-compatible API emulator.

## Architecture Topology
- **VPC (`aws_vpc`):** Isolated virtual network (`10.0.0.0/16`)
- **Public Subnet (`aws_subnet`):** Dedicated compute tier (`10.0.1.0/24`) in `us-east-1a`
- **Internet Gateway (`aws_internet_gateway`):** Ingress/egress gateway
- **Routing (`aws_route_table` & `aws_route_table_association`):** Default internet route (`0.0.0.0/0`)
- **Perimeter Firewall (`aws_security_group`):** Ingress for TCP 80 (HTTP) and TCP 22 (SSH)
- **Virtual Machine (`aws_instance`):** `t2.micro` compute instance

## Key Engineering Takeaways
1. **Declarative vs. Imperative:** Shifted from manual Bash reverse-teardown scripts to an automated dependency graph (`tofu apply` and `tofu destroy`).
2. **Dynamic Decoupling:** Replaced hardcoded values with structured inputs (`variables.tf`) and runtime outputs (`outputs.tf`).
3. **Drift Detection & Reconciliation:** Simulated out-of-band tag tampering and restored compliance via execution plans (`tofu plan`).

## Quickstart
```bash
tofu init
tofu plan
tofu apply -auto-approve
tofu destroy -auto-approve