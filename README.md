# move_terraform_state
Example code on how a terraform state could be moved from local to remote backend.


# TO-DO

# DONE

- Create 1 folder for sample code, run terraform apply
- Create a folder for random_pet
- move the state
- add a remote state backend to state push to TFE
- Update code to reference the remote state
- reference the state on random_pet
- Note: not sure this will work, lets try
- Terraform apply should say the nothing to be created, state should persists.
- Terraform destroy should work and delete the existing state


# How this example  was created

- Create a `main.tf` file with the following contents: 

```
resource "random_pet" "name" {
  length    = "4"
  separator = "-"
}

output "random_pet_name_id" {
  value = "${random_pet.name.id}"
}

resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo Hello ${random_pet.name.id}"
  }
}

```

- Initialize and apply the configuration you created: 

```
terraform init

terraform apply
```

- Create a folder, where your terraform modules will reside, i.e. :

```
mkdir modules
```
- Go to the directory you created and create a new file with a .tf extension: 

```
# The name of the file before the .tf is going to be your module name
touch random_pet.tf
```
- Edit your main.tf to use the module you created: 

```
module "random_pet" {
  source = "modules/"
}

resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo Hello ${module.random_pet.random_pet_name_id}"
  }
}

```
- Here the things start to get little tricky: 
   - if you run ``` terraform plan ```, you will see that there is a new resource to be created
   - this however is not what we are aiming for, since we alread have that resource created
   - what you need to do is to move the state of the already created resource to be the state of the module you created

- Move the state to the newly created module

```
terraform state mv random_pet.name module.random_pet
```

- Run a plan operation to ensure that no new resources are going to be created

```
terraform plan
```


# How to use this repository 


- Clone the repository


- Go in the cloned repo directory


- Run the following command



