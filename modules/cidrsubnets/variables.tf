variable "ipv4-cidr-block" {
  description = "The ipv4 cidr block address space to partition"
  type        = string
}

variable "list_newbits" {
  description = "The list of numbers representing the newbits to be passed to cidrsubnets function. Newbits specify the number of additional network prefix bits for one returned address range"
  type        = list(number)
}