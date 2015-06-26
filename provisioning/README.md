This ansible project was created by Data Curation Experts and sponsored by Chemical Heritage Foundation. It builds a production-style hydra head on an Ubuntu 14.04 Amazon EC2 instance.

To use this project, you must have Ansible installed. See http://docs.ansible.com/intro_installation.html for instructions.

To create an ec2 instance:
1. add your AWS credentials in the vars/main.yml files in the launch_ec2 and ec2 roles
2. override any other default variables you wish to change (we definitely recommend overriding the postgresql database, user, and password settings in the Services role)
3. run 

```
ansible-playbook -i hosts ec2.yml
````

This setup expects your code to be deployed with Capistrano. In your codebase, make sure config/deploy.rb will deploy your project to the correct directory - the `:deploy_to` setting in Capistrano should match the housekeeping role's `project_name` variable. If you use the default value for `project_name` in the housekeeping role, your config/deploy.rb should use 

```
set :deploy_to, '/opt/sufia-project'
```

To use this code with Vagrant:
1. create a Vagrant project
2. modify the Vagrantfile to use Ansible (see sample Vagrantfile for ideas)
3. clone this project as the provisioning sub-directory of your Vagrant project
