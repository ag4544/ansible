ops_20_nginx_install
=========

This role install nginx on debian-based operating system

Requirements
------------

You need any debian-based OS

Role Variables
--------------

No variables

Dependencies
------------

Role ops_20_copy_vault depends on this role

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
---
- name: Install nginx and copy config and encryptedfiles
  hosts: all

  roles:
    - ops_20_copy_vault
```

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
