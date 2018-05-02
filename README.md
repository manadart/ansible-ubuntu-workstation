# Workstation Bootstrap Based on Ubuntu Server

Install the latest Ansible.
```
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
```

Run this playbook.
```
sudo ansible-pull -U https://github.com/manadart/ansible-ubuntu-workstation
```
