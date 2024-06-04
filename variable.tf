variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure resources."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the resources."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "The address prefixes of the Azure subnet."
  type        = list(string)
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID."
  type        = string
}

variable "client_id" {
  description = "The client ID (application ID) of the service principal."
  type        = string
}

variable "client_secret" {
  description = "The client secret of the service principal."
  type        = string
}

variable "principal_id" {
  description = "The Azure principal ID"
  type        = string
}

variable "role_definition_id" {
  description = "The ID of the role definition to assign to the user."
  type        = string
}

variable "vnet_cidr" {
  description = "The CIDR block for the Azure Virtual Network (VNet)."
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space of the Azure virtual network."
  type        = list(string)
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet within the Azure Virtual Network (VNet)."
  type        = string
}

variable "user_display_name" {
  description = "The display name of the Azure AD user."
  type        = string
}

variable "user_principal_name" {
  description = "The user principal name (UPN) of the Azure AD user."
  type        = string
}

variable "user_mail_nickname" {
  description = "The mail nickname of the Azure AD user."
  type        = string
}

variable "user_password" {
  description = "The password of the Azure AD user."
  type        = string
}