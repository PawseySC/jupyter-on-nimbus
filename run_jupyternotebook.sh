#!/bin/bash

pubkey_path="$1"
jupyternotebook_version="$2"
public_ip_address=$(curl ifconfig.me)
jupyternotebook_token=$(sudo singularity exec datascience-notebook_"$jupyternotebook_version.sif" jupyter notebook list | grep -oP -m 1 '8888.{0,}' | awk '{print $1}')

echo '---------------------------------------------------------------------------------------------------------------------------------


            Run the following command on your local computer to enable port forwarding from this instance to your local computer:           

            ssh -i '$pubkey_path' -N -f -L 8888:localhost:8888 ubuntu@'$public_ip_address'          

            Then go to a web browser and enter the following URL to run your conda Jupyter notebook: http://localhost:'$jupyternotebook_token'            

            After exiting the Jupyter Notebook, close the 8888 port on your local computer****: lsof -ti:8888 | xargs kill -9           



---------------------------------------------------------------------------------------------------------------------------------'