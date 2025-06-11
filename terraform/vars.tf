variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nome do Key Pair já cadastrado ou a criar"
  type        = string
  default = "fabio-keyy"
}

variable "public_key_path" {
  description = "Caminho local para a sua chave pública (ex: ~/.ssh/id_rsa.pub)"
  type        = string
  default = "/home/fabio_oliveira/.ssh/keys/public/fabio-keyy.pub"
}
