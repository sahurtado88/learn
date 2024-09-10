# Used in creation of AKS secrets which is then used during helm deploy
output "pg_fqdn" {
  value = azurerm_postgresql_server.pg.fqdn
}
output "id" {
  value = azurerm_postgresql_server.pg.id
}
output "name" {
  value = azurerm_postgresql_server.pg.name
}