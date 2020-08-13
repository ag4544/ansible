server_load_balancer
=========

This role configures frontend (load balancer) server

Requirements
------------

You need any debian-based OS

Role Variables
--------------

destination_nginx_config: destination to nginx config file
backend_fqdn: full name of backend server

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
