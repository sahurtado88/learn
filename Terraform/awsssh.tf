terraform {
required_version = ">= 1.0.0"
 required_providers {
    aws = {
        source = "hashicorp/aws"
    }
    http = {
        source = "hashicorp/http"
        version = "2.1.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.1.0"
    }
    local = {
        source = "hashicorp/local"
        version = "2.1.0"
        }
    tls = {
        source = "hashicorp/tls"
        version = "3.1.0"
    }
 }  
}

resource "tls_private_key" "generated" {
    algorithm = "RSA"
}
resource "local_file" "private_key_pem" {
    content = tls_private_key.generated.private_key_pem
    filename = "MyAWSKey.pem"
}

resource "aws_key_pair" "generated" {
key_name = "MyAWSKey"
public_key = tls_private_key.generated.public_key_openssh
lifecycle {
ignore_changes = [key_name]
}
}

