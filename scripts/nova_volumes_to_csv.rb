#!/bin/sh
exec ruby -x "$0" "$@"
#!ruby -w

require 'date'
require(File.expand_path('../lib/nova_helper.rb', File.dirname(__FILE__)))
require(File.expand_path('../lib/script_helper.rb', File.dirname(__FILE__)))

ScriptHelper.print_script_version
ScriptHelper.print_ruby_version

opts = ScriptHelper.parse_options ARGV
output_dir = opts['output-directory']
ScriptHelper.log_info "Parameters: #{ARGV.inspect}"

# This script lists the nova volumes for the current tenant and converts it to a comma separated csv
file_location = ScriptHelper.calculate_output_filename(output_dir,"nova_volumes", "csv")

ScriptHelper.log_info "Printing volumes to file..."
nova_output = `nova volume-list`
NovaHelper.write_csv_from_output(nova_output, file_location)
ScriptHelper.log_info "Finished printing volumes to file."
