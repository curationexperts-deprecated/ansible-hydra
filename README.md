This vagrant/ansible project builds a hydra head on Fedora 4.

The project sets up the vm for deployment via capistrano. In your codebase, make sure config/deploy.rb will deploy your project to the correct directory:
```
set :deploy_to, '/opt/sufia'
```
 
