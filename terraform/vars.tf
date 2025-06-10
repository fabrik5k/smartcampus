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
}

variable "public_key_path" {
  description = "Caminho local para a sua chave pública (ex: ~/.ssh/id_rsa.pub)"
  type        = string
}

variable "git_repo_url" {
  description = "URL do repositório Git com seu projeto"
  type        = string

}

