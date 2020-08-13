---
all:
  hosts:
  vars:
    ansible_user: root
    ansible_ssh_private_key_file: ~/.ssh/ansible_tasks
  children:
    lb:
      hosts:
        ${server_name_lb}:
    app:
     hosts:
        ${server_name_app}:
