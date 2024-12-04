data "vault_generic_secret" "docdb" {
  path = "docdb/${var.env}"
}