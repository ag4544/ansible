install-nginx
=========

This role installs nginx to vps at hosts.txt and makes basic configuration

Requirements
------------

You need debian-based or RHEL/Centos operating system

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
---
- name: Install nginx depending on OS
  hosts: all

  roles:
    - install-nginx

```
launch: ansible-playbook -i hosts.txt ansible-task7.yml

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
