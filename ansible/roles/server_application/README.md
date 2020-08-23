server_application
=========

This role configures backend server

Requirements
------------

You need any debian-based OS

Role Variables
--------------

destination_site: destination to sites-available
destination_test_html: destination to html file test.html

Dependencies
------------

This role runs automatically with terraform task12.tf

Example Playbook
----------------


```
---
- name: Configure backend server
  hosts: backend

  roles:
    - server_application

```

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
