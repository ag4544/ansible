ops_16_nginx
=========

This role installs nginx to vps at hosts.txt and makes basic configuration

Requirements
------------

You need any debian-based operating system

Role Variables
--------------
No variables

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
    - ops_16_nginx

```
launch: ansible-playbook -i hosts.txt ansible-task6.yml

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
