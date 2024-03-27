variable "keypair" {
    type = string
}

variable "sg" {
    type = list(string)
}

variable "flavor" {
    type=string
}

variable "image-id" {
    type=string
}

variable "network-name" {
    type=string
}