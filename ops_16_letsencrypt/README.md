ops_16_letsencrypt
=========

This role installs letsencrypt to vps at hosts.txt, gets a certificate from letsencrypt CA and updates it automatically using cron

Requirements
------------

You need any debian-based operating system

Role Variables
--------------

destinationsite: location of sites-available


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
    - ops_16_letsencrypt

```
launch: ansible-playbook -i hosts.txt ansible-task6.yml

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
