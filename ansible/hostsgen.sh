#!/bin/bash
ansible-inventory --graph -i aws_ec2.yaml | sed -n -e '/compute/ s/.*\\-- *//p' >hosts
