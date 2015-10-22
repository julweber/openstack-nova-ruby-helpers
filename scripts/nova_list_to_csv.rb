#!/bin/sh
exec ruby -x "$0" "$@"
#!ruby -w

require 'date'
require(File.expand_path('../lib/nova_helper.rb', File.dirname(__FILE__)))

require 'pry'
binding.pry

# This script lists the nova vms for the current tenant and converts it to a comma separated csv
file_location = "nova_machines-#{Date.today.to_s}.csv"

nova_output = `nova list`
NovaHelper.write_csv_from_output(nova_output, file_location)
