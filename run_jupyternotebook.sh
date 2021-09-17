#!/bin/bash

pubkey_path="$1"
public_ip_address=$(curl ifconfig.me)
jupyternotebook_token=$(sudo singularity exec base-notebook_latest.sif jupyter notebook list | grep -oP -m 1 'token=.{0,}' | awk '{print $1}')

echo 'Run the following command on your local computer to enable port forwarding from this instance to your local computer:
ssh -i '$pubkey_path' -N -f -L 8080:localhost:8080 ubuntu@'$public_ip_address'

Then go to a web browser and enter the following URL to run your conda Jupyter notebook: http://localhost:8080/?'$jupyternotebook_token'


****After exiting the Jupyter Notebook, close the 8080 port on your local computer****: lsof -ti:8080 | xargs kill -9'
