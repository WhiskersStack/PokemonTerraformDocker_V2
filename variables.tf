variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-075686beab831bb7f" # Example AMI ID, replace with your own
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t3.medium" # Example instance type, replace with your own
}
# variable "tags" {
#   description = "Tags to apply to the instance"
#   type        = map(string)
#   default = {
#     Name = "PokemonGame" # Default tag, can be overridden
#   }
# }

