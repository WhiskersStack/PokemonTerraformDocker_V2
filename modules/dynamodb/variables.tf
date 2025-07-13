variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for DynamoDB table"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Partition key name"
  type        = string
}

variable "hash_key_type" {
  description = "Partition key type (S | N | B)"
  type        = string
}

variable "range_key" {
  description = "Sort key name"
  type        = string
}

variable "range_key_type" {
  description = "Sort key type (S | N | B)"
  type        = string
}

variable "tags" {
  description = "Tags for the DynamoDB table"
  type        = map(string)
  default     = {}
}
