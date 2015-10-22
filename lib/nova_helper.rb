require 'csv'
require 'pp'
require(File.expand_path('./script_helper.rb', File.dirname(__FILE__)))

class NovaHelper
  def self.write_csv_from_output(nova_output, file_name)
    lines = transform_nova_output nova_output

    ScriptHelper.log_info "Writing to file: #{file_name}"
    CSV.open(file_name, "wb") do |csv|
      lines.each do |line|
        csv << line
      end
    end
  end

  def self.write_vm_details_to_file(file_name)
    details = get_vms_details
    ScriptHelper.write_string_array_to_file(file_name, details)
  end

  protected

  def self.get_vms_details
    nova_result = `nova list`
    output = []
    lines = transform_nova_output nova_result
    lines.each do |line|
      vm_id = line.first
      result = `nova show #{vm_id}`
      output << result
    end
    output
  end

  def self.transform_nova_output(nova_output)
    lines = nova_output.split("\n")
    lines.delete_at(2)
    lines.delete_at(0)
    lines.delete_at(lines.count-1)
    lines.map! do |line|
      line[2..-2].split("|")
    end
    return lines
  end
end
