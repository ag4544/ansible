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
- name: Configure load balancer
  hosts: lb

  roles:
    - server_load_balancer

- name: Configure application server
  hosts: app

  roles:
    - server_application
```

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
