

## DNS Terminologies

• Domain Registrar : Amazon Route 53, GoDaddy, …
• DNS Records: A, AAAA, CNAME, NS, …
• Zone File: contains DNS records
• Name Server : resolves DNS queries (Authoritative or Non-Authoritative)
• Top Level Domain (TLD): .com, .us, .in, .gov, .org, …
• Second Level Domain (SLD): amazon.com, google.com, …

## Record Types
• A – maps a hostname to IPv4
• AAAA – maps a hostname to IPv6
• CNAME – maps a hostname to another hostname
    • The target is a domain name which must have an A or AAAA record
    • Can’t create a CNAME record for the top node of a DNS namespace (Zone
    Apex)
    • Example: you can’t create for example.com, but you can create for
    www.example.com
• NS – Name Servers for the Hosted Zone
    • Control how traffic is routed for a domain

## CNAME vs Alias
• AWS Resources (Load Balancer, CloudFront...) expose an AWS hostname:
    • lb1-1234.us-east-2.elb.amazonaws.com and you want myapp.mydomain.com

• CNAME:
    • Points a hostname to any other hostname. (app.mydomain.com => blabla.anything.com)
    • ONLY FOR NON ROOT DOMAIN (aka. something.mydomain.com)
• Alias:
    • Points a hostname to an AWS Resource (app.mydomain.com => blabla.amazonaws.com)
    • Works for ROOT DOMAIN and NON ROOT DOMAIN (aka mydomain.com)
    • Free of charge
    • Native health check

## Alias Records
• Maps a hostname to an AWS resource
• An extension to DNS functionality
• Automatically recognizes changes in the
resource’s IP addresses
• Unlike CNAME, it can be used for the top node
of a DNS namespace (Zone Apex), e.g.:
example.com
• Alias Record is always of type A/AAAA for
AWS resources (IPv4 / IPv6)
• You can’t set the TTL

## Routing Policies
• Define how Route 53 responds to DNS queries
• Don’t get confused by the word “Routing”
• It’s not the same as Load balancer routing which routes the traffic
• DNS does not route any traffic, it only responds to the DNS queries
• Route 53 Supports the following Routing Policies
• Simple
• Weighted
• Failover
• Latency based
• Geolocation
• Multi-Value Answer
• Geoproximity (using Route 53 Traffic Flow feature)

## Health Checks
• HTTP Health Checks are only for public
resources
• Health Check => Automated DNS Failover:
1. Health checks that monitor an endpoint
(application, server, other AWS resource)
2. Health checks that monitor other health
checks (Calculated Health Checks)
3. Health checks that monitor CloudWatch
Alarms (full control !!) – e.g., throttles of
DynamoDB, alarms on RDS, custom metrics,
… (helpful for private resources)
• Health Checks are integrated with CW
metrics