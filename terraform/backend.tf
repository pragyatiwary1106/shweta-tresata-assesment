terraform {
  backend "azurerm" {
    storage_account_name = "backendterraformaks1106"        
    container_name       = "tfstate"                             
    key                  = "tfstate/config/"   
    # access_key can be set via ARM_ACCESS_KEY environment variable

}
}