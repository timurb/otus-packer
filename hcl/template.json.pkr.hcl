# This file was autogenerated by the BETA 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/from-1.5/variables#type-constraints for more info.
variable "folder_id" {
  type    = string
}

variable "subnet_id" {
  type    = string
}

variable "token" {
  type    = string
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
#could not parse template for following block: "template: generated:7: function \"clean_resource_name\" not defined"

source "yandex" "autogenerated_1" {
  disk_type           = "network-ssd"
  folder_id           = "${var.folder_id}"
  image_description   = "my custom ubuntu with nginx"
  image_family        = "ubuntu-web-server"
  image_name          = "ubuntu-2004-lts-nginx-${timestamp()}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  subnet_id           = "${var.subnet_id}"
  token               = "${var.token}"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  sources = ["source.yandex.autogenerated_1"]

  provisioner "shell" {
    inline = ["echo 'updating apt cache'", "sudo apt update -y", "sudo apt install -y nginx nano git", "sudo systemctl enable nginx", "curl localhost"]
  }
}
