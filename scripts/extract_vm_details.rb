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

file_location = ScriptHelper.calculate_output_filename(output_dir,"nova_vm_details", "txt")

ScriptHelper.log_info "Extracting VM Details to file..."
NovaHelper.write_vm_details_to_file file_location
ScriptHelper.log_info "Finished extracting VM Details to file."
