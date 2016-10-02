Builds a production-style Hydra head on an Amazon EC2 instance or a vagrant box. Supports Ubuntu 14.04, Debian Squeeze, and Centos 7. 

## Prerequisites
[Ansible](http://docs.ansible.com/intro_installation.html) 2.0 or above.

## Variables
This project uses a large number of variables. Defaults are included in each role - they are appropriate for an Ubuntu 14.04 build. Please review the sample variables files for more information.

## AWS / EC2 setup
Step-by-step instructions were presented in our 2015 Hydra Connect talk: [Deploying Hydra with Ansible and AWS](https://wiki.duraspace.org/download/attachments/67241821/Deploying%20Hydra%20with%20Ansible%20and%20AWS%281%29.pdf?version=1&modificationDate=1443113768038&api=v2) -- The presentation is image-heavy and the [accompanying notes](https://wiki.duraspace.org/download/attachments/67241821/DevOpsHydraConnectDeployingHydrawithAnsibleandAWS.pdf?version=1&modificationDate=1449085395026&api=v2) provide more detail.

## Execution
To create, set up an ec2 instance:

1. Copy group_vars/sample_all to group_vars/all.
2. Add your organization's AWS credentials there.
3. Add/change any other variables you wish to override.
4. Consider protecting group_vars/all with ansible-vault.
5. run `ansible-playbook -i hosts --private-key /path/to/your/keypair.pem create_ec2.yml`
   * Optional: if you encrypted your variables with ansible-vault, add `--ask-vault-pass`
   * Optional: The scripts will by default launch an instance tagged 'staging'. If you want a different tag, override the 'aws_tag' variable either in a file (i.e. group_vars/all) or directly from the command line by adding: `--extra-vars "aws_tag=production"`
6. Note that this playbook is NOT idempotent -- it creates a new instance on AWS each time it is run.

There's another playbook called configure.yml. It's included by create_ec2 but can also be run separately. This playbook IS idempotent, so it can be used to change configuration at will. Also, AWS-related tasks have been removed (let us know if you run into anything!) so it should be more generalizable. Note that to run this playbook you must specify a hosts variable (see comment in configure.yml).

## Deployment
This project expects your code to be deployed with [Capistrano](http://capistranorb.com/). In your Hydra head (the codebase you're deploying), configure Capistrano for your server(s). In `config/deploy.rb` and/or in `config/deploy/<yourenv>.rb` you must:  
	* share the log directory by including `log` in your Capistrano `linked_dirs` list and  
	* set the Capistrano `:deploy_to` directory to match the capistrano_setup role's `project_base` variable. If you use the default value for `project_base` in the capistrano_setup role, you should use 
```
set :deploy_to, '/opt/sufia-project'
```

## Vagrant
[Vagrant](http://docs.vagrantup.com/v2/)

### A production-like vagrant box
To set up a production-like Vagrant box (for staging, troubleshooting) for your project:

1. Create a Vagrant file in your project
  * (see sample_Vagrantfile for ideas)
  * Be sure to point to the vagrant_staging.yml file, which skips aws-related roles
2. Clone this repository alongside your project
3. Copy group_vars/sample_all to group_vars/all.
 * Add/change any other variables you wish to override.
 * Consider protecting group_vars/all with ansible-vault.
4. cd into your project and run `vagrant up`
5. TODO: deploy your capistrano project to your vagrant box. Haven't tried this yet.

### A development vagrant box

1. Create a Vagrant file in your project
  * (see sample_Vagrantfile for ideas)
  * Be sure to point to the vagrant_dev.yml file
2. Clone this repository alongside your project
3. Copy group_vars/sample_all to group_vars/all.
 * Add/change any other variables you wish to override.
 * Consider protecting group_vars/all with ansible-vault.
4. In your application code, edit
  * development section of config/blacklight.yml to url: http://localhost:8080/hydra/collection1
  * development section of config/fedora.yml to url: http://127.0.0.1:8080/fedora/rest
  * create a file config/solr.yml with a development section containing url: http://localhost:8080/hydra
  * (see roles/hydra-stack/config/ for more context)
5. run `vagrant up`
6. 'vagrant ssh'; cd /vagrant; 'bundle install'
7. sudo service resque-pool start (resque-pool can't start until bundler has run)
8. sudo service apache2 restart

## Contributing
Contributions are welcome in the form of issues (including bug reports, use cases) and pull requests.

## Origins
This Ansible project was created by Data Curation Experts for the Chemical Heritage Foundation.
