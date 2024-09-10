locals {
  # Applies to Web Application Firewall 
  whitelist_ip_range = [
    "205.175.240.240/29",
    "205.175.202.0/24",
    "130.151.0.0/16",
    "131.200.0.0/16",
    "192.159.76.0/24",
    "192.94.123.0/24",
    "205.175.197.0/24",
    "205.175.238.0/24",
    "205.175.250.0/24",
    "208.22.104.0/25",
    "52.154.233.171/32",
    "52.173.88.220/30",
    "13.67.221.244/31",
    "205.175.207.240/28",
    "12.90.175.62/32",
    "72.138.191.182/32", # brq-montreal
    "207.107.70.202/32", # brq-montreal
    "98.174.227.98/31",  # sde-phoenix
    "40.122.224.211/32", # ede-central
    "20.29.125.222/32",  # ede-central
    "20.12.190.104/32",  # ede-central
    "20.12.239.45/32",   # ede-central
    "20.12.239.9/32",    # ede-central
    "20.29.66.158/31",   # ede-centralus
    "13.86.6.208/32",    # hub2-centralus
    "52.143.247.86/32",  # hub2-centralus
    "52.143.240.14/32",  # hub2-centralus
    "20.37.132.157/32",  # hub2-centralus
    "52.143.247.93/32",  # hub2-centralus
    "20.37.133.193/32",  # hub2-centralus
    "20.37.135.92/32",   # hub2-centralus
    "20.84.216.116/32",  # hub2-centralus
    "20.221.107.71/32",  # hub2-centralus
    "20.221.107.62/32",  # hub2-centralus
    "20.106.11.54/32",   # hub2-centralus
    "52.141.219.104/32", # hub2-centralus
    "13.86.2.17/32",     # hub2-centralus
    "13.89.115.62/32",   # hub2-centralus
    "13.86.61.179/32",   # hub2-centralus
    "20.37.143.88/32",   # hub2-centralus
    "20.221.122.182/32", # hub2-centralus
    "20.221.48.105/32",  # hub2-centralus
    "52.185.78.96/28",   # NAT Gateway hub2-centralus
    "20.52.209.31/32",   # ede-germanywestcentral
    "20.170.35.84/31",   # ede-germanywestcentral
    "20.212.129.255/32", # ede-southeastasia
    "20.205.202.126/31", # ede-southeastasia
    "20.10.249.144/28",  # eastus2
    "52.252.195.16/28",  # northcentralus
  ]

  # Applies to AKS
  whitelist_infra_ip_range = [
    "205.175.240.240/29",
    "205.175.202.0/24",
    "130.151.0.0/16",
    "131.200.0.0/16",
    "192.159.76.0/24",
    "192.94.123.0/24",
    "205.175.197.0/24",
    "205.175.238.0/24",
    "205.175.250.0/24",
    "208.22.104.0/25",
    "52.154.233.171/32",
    "52.173.88.220/30",
    "13.67.221.244/31",
    "205.175.207.240/28",
    "12.90.175.62/32",
    "98.174.227.98/31",  # sde-phoenix
    "40.122.224.211/32", # ede-central
    "20.29.125.222/32",  # ede-central
    "20.12.190.104/32",  # ede-central
    "20.12.239.45/32",   # ede-central
    "20.12.239.9/32",    # ede-central
    "20.29.66.158/31",   # ede-centralus
    "13.86.6.208/32",    # hub2-centralus
    "52.143.247.86/32",  # hub2-centralus
    "52.143.240.14/32",  # hub2-centralus
    "20.37.132.157/32",  # hub2-centralus
    "52.143.247.93/32",  # hub2-centralus
    "20.37.133.193/32",  # hub2-centralus
    "20.37.135.92/32",   # hub2-centralus
    "20.84.216.116/32",  # hub2-centralus
    "20.221.107.71/32",  # hub2-centralus
    "20.221.107.62/32",  # hub2-centralus
    "20.106.11.54/32",   # hub2-centralus
    "52.141.219.104/32", # hub2-centralus
    "13.86.2.17/32",     # hub2-centralus
    "13.89.115.62/32",   # hub2-centralus
    "13.86.61.179/32",   # hub2-centralus
    "20.37.143.88/32",   # hub2-centralus
    "20.221.122.182/32", # hub2-centralus
    "20.221.48.105/32",  # hub2-centralus
    "52.185.78.96/28",   # NAT Gateway hub2-centralus
    "20.52.209.31/32",   # ede-germanywestcentral
    "20.170.35.84/31",   # ede-germanywestcentral
    "20.10.249.144/28",  # eastus2
    "52.252.195.16/28",  # northcentralus
  ]
}
