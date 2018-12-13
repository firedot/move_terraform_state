terraform {
backend "atlas" {
name = "HiveCorp/TF_STATE_Move"
}
}
module "random_pet" {
  source = "modules/"
}

resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo Hello ${module.random_pet.random_pet_name_id}"
  }
}
