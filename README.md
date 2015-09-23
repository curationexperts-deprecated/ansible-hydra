This Ansible project was created by Data Curation Experts for the Chemical Heritage Foundation. It builds a production-style Hydra head on an Ubuntu 14.04 Amazon EC2 instance.

## Prerequisites
[Ansible](http://docs.ansible.com/intro_installation.html) 1.9 or above.

## AWS / EC2 setup
TODO

## Execution
To create an ec2 instance:

1. Copy group_vars/sample_all to group_vars/all.
2. Add your organization's AWS credentials there.
3. Add any other variables you wish to override.
4. Consider protecting group_vars/all with ansible-vault.
5. run `ansible-playbook -i hosts --private-key /path/to/your/keypair.pem ec2.yml`
   * Optional: if you encrypt your variables with ansible-vault, add `--ask-vault-pass`
   * Optional: The scripts will by default launch an instance tagged 'staging'. If you want a different tag, override the 'instance_type' variable either in a file (i.e. group_vars/all) or directly from the command line by adding: `--extra-vars "instance_type=production"`

## Deployment
This project expects your code to be deployed with [Capistrano](http://capistranorb.com/). In your Hydra head (the codebase you're deploying), set the Capistrano `:deploy_to` directory to match the housekeeping role's `project_name` variable. If you use the default value for `project_name` in the housekeeping role, you should use 
```
set :deploy_to, '/opt/sufia-project'
```
in `config/deploy.rb` and/or in `config/deploy/<yourenv>.rb`  

## Vagrant
To use this project with [Vagrant](http://docs.vagrantup.com/v2/):

1. Create a Vagrant project
2. Modify the Vagrantfile to use Ansible (see sample Vagrantfile for ideas)
3. Be sure to point to the vagrant.yml file, which skips the launch_ec2 and ec2 roles
4. Clone this project as the `provisioning` sub-directory of your Vagrant project
5. Run `vagrant up`
