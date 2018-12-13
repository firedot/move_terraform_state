resource "random_pet" "name" {
  length    = "4"
  separator = "-"
}

output "random_pet_name_id" {
  value = "${random_pet.name.id}"
}
