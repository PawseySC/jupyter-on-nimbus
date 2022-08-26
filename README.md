# Automated deployment of Jupyter Notebook

## Summary
This repository covers the scripts for running Jupyter Notebook with Ansible on cloud services. The Jupyter Datascience Notebook container is pulled from Docker Hub to build a Singularity container. This allows the container to be used on HPC if required. 


## Before you start

1. It is recommended that users change their Singularity cache directory to a storage volume, as the default is in the `/home` directory, i.e. `/home/ubuntu/.singularity/cache`, which can run out of space quickly. To change it, simply create a new directory and update the `$SINGULARITY_CACHEDIR` variable to it. It is also recommended that you have your storage volume [mounted to a directory named `/data`](https://support.pawsey.org.au/documentation/display/US/Attach+a+Storage+Volume).
    
    **Skip this step if you do not have a storage volume.**

        mkdir /data/singularity_cache
        SINGULARITY_CACHEDIR=/data/singularity_cache

2. Ensure that you have port 8888 open for your instance, you can do so on the Nimbus dashboard following these [instructions](https://support.pawsey.org.au/documentation/pages/viewpage.action?pageId=92832676#NimbusforBioinformatics-JupyterNotebook).


## Quick start
This is an interactive deployment, such that when the Ansible playbook script is run, the user will be prompted to enter directory paths and other information as required.

**Note that the time taken for this deployment varies, and if run for the first time, will require several minutes for the container to be pulled and built as a Singularity container. Ensure that your computer does not go to sleep during this time.**

### Prerequisite
This Ansible playbook works on Ubuntu 18.04 and Ubuntu 20.04. Other operating systems and versions will require testing. Raise a ticket if you face issues running this with other operating systems.

Ansible needs to be installed on the machine.

### Supported versions
We support only the latest version at present.

### Install Ansible (if it is not already installed)

    sudo apt install --yes software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install --yes ansible
    
### Clone this repo and run the Ansible script

    git clone https://github.com/PawseySC/jupyter-on-nimbus.git
    cd jupyter-on-nimbus
    ansible-playbook ansible-jupyternotebook.yaml

    #If you make a mistake answering the prompts, cancel (control+c) and rerun the `ansible-playbook` command.

## Open a web browser and access your Jupyter notebook

Once you have run the above, you can use the token generated and login to your Jupyter notebook from a web browser using your instance IP address and the port 8888, e.g. `146.118.XX.XX:8888`

On the notebook console, you should see all the files in your current working directory. Start a new Python 3 kernel to begin using your notebook. All libraries/packages as well as output data will be saved under your current working directory.

You may need to append your module path to use the correct library paths, for e.g.:

    import sys
    sys.path.append('/usr/lib/python3.8')
    sys.path.append('/usr/local/lib/python3.8')

ou may also have a different version of Python on your instance, to the one on the container. Ensure that they are the same versions by updating the one on your instance, or choosing a container that has the same version of Python as the one on your instance.

## Check for current notebooks

    singularity exec /data/containers/datascience-notebook_latest.sif jupyter notebook list

## Stop notebook

    singularity exec /data/containers/datascience-notebook_latest.sif jupyter notebook stop 8888


## Notes

It is advisable to clean the Singularity cache from time to time - when image pulls are completed. To clean it, first list and check that you are happy to remove the cache:

    singularity cache list
    singularity cache clean

    ** Use sudo if you did not change the $SINGULARITY_CACHEDIR variable **
    sudo singularity cache list
    sudo singularity cache clean