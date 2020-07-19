ops_15_nginx
=========

This role installs nginx to vps at hosts.txt and makes basic configuration

Requirements
------------

You need any debian-based operating system

Role Variables
--------------
listen_port: port to listen by nginx

rootdir: directory, that would be shown, when you go to :listen_port

ports: list of test variables

testvars: list of another test variables

destinationsite1: location of sites-available

destination_config: location of nginx.conf

Dependencies
------------
No Dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
- name: Install nginx and copy config files
  hosts: all

  roles:
    - ops_15_nginx

```
launch: ansible-playbook -i hosts.txt ansible-task5.yml

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
