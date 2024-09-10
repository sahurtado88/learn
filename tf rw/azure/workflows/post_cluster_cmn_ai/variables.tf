variable "env_prefix" {}
variable "env_name" {}
variable "openai_location" {}
# This a custom token. Recommended to override for each environment.
variable "openai_bearer_token" {
  default   = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
  sensitive = true
}
