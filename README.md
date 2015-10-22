# openstack-nova-ruby-helpers
Some Ruby helper scripts to interact with the nova CLI.

# Usage

Please verify that you have sourced the correct openrc.sh file to be able to properly use the nova cli, e.g.:

    source ~/openstack-access/anynines-openrc.sh

# Start the scripts as needed, e.g.

    ./scripts/nova_list_to_csv.rb --output-directory=/tmp
    ./scripts/nova_volumes_to_csv.rb --output-directory=/tmp
    ./scripts/extract_vm_details.rb --output-directory=/tmp

# or execute all info scripts using

    ./scripts/execute_info_scripts.sh /tmp
