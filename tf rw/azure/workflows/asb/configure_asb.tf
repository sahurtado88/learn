resource "azurerm_servicebus_namespace" "asb_namespace" {
  name                = "${var.env_prefix}-${var.env_name}-broker-ns"
  location            = var.location
  resource_group_name = local.rg_general
  sku                 = var.asb_namespace_sku
}

resource "azurerm_servicebus_topic" "asb_topic_event" {
  name         = "topic-event"
  namespace_id = azurerm_servicebus_namespace.asb_namespace.id
}

resource "azurerm_servicebus_topic_authorization_rule" "asb_topic_event_authorization_rule" {
  name     = "topic-event-sasPolicy"
  topic_id = azurerm_servicebus_topic.asb_topic_event.id
  listen   = true
  send     = true
  manage   = true
}

resource "azurerm_servicebus_topic" "asb_topic_mgmt" {
  name         = "topic-mgmt"
  namespace_id = azurerm_servicebus_namespace.asb_namespace.id
}

resource "azurerm_servicebus_topic_authorization_rule" "asb_topic_mgmt_authorization_rule" {
  name     = "topic-mgmt-sasPolicy"
  topic_id = azurerm_servicebus_topic.asb_topic_mgmt.id
  listen   = true
  send     = true
  manage   = true
}
