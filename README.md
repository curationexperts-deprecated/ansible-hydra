This ansible project was created by Data Curation Experts for the Chemical Heritage Foundation. It builds a production-style hydra head on an Ubuntu 14.04 Amazon EC2 instance. The encrypted files contain variables that apply only to CHF. 

Before you can use this project, you must [install Ansible](http://docs.ansible.com/intro_installation.html).

To create an ec2 instance for an organization other than CHF:

1. create new vars/main.yml files in the launch_ec2 and ec2 roles  
2. add your organization's AWS credentials there
3. create a new vars/main.yml file in the services role  
4. override any default variables you wish to change there (we definitely recommend overriding the postgresql database, user, and password settings)  
5. run `ansible-playbook -i hosts --private-key /path/to/your/keypair.pem ec2.yml` (if you encrypt your variables with ansible-vault, add `--ask-vault-pass`)  

This project expects your code to be deployed with [Capistrano](http://capistranorb.com/). In your Hydra head (the codebase you're deploying), set the Capistrano `:deploy_to` directory to match the housekeeping role's `project_name` variable. If you use the default value for `project_name` in the housekeeping role, you should use 
```
set :deploy_to, '/opt/sufia-project'
```
in `config/deploy.rb` and/or in `config/deploy/<yourenv>.rb`  

To use this project with [Vagrant](http://docs.vagrantup.com/v2/):

1. create a Vagrant project  
2. modify the Vagrantfile to use Ansible (see sample Vagrantfile for ideas)  
3. clone this project as the `provisioning` sub-directory of your Vagrant project  
4. run `vagrant up`

