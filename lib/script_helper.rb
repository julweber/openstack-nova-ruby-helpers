require 'date'

class ScriptHelper

  @@executed_script_name = nil

  ## Options parser helper
  # The parse options transformers the given args array into an options hash
  # e.g. ["--manifest=~/test", "--number=3"] => { 'manifest' => '~/test', 'number' => '3' }
  #
  # @param args [Array] the full arguments array
  # @param number_of_items_to_drop [Integer] how many array items should be dropped from the beginning
  def self.parse_options(args, number_of_items_to_drop = 0)
    options = {}
    args.dup.drop(number_of_items_to_drop).each do |entry|
      key_val = entry.split("=")
      options[key_val[0].gsub!('--','')] = key_val[1]
    end
    log_info "Using options: #{options.inspect}"
    options
  end

  def self.calculate_output_filename(base_directory = nil,base_filename, extension)
    today = Date.today
    output = ""
    unless base_directory.nil?
      output = base_directory
      output = "#{base_directory}/" unless base_directory[base_directory.length-1] == "/"
    end
    "#{output}#{base_filename}-#{today.to_s}.#{extension}"
  end

  def self.write_string_array_to_file(file_location, string_array)
    File.open(file_location, 'w') do |file|
      string_array.each do |item|
        file.write item
      end
    end
  end

  def self.parse_yaml(yaml_file_path)
    YAML.load_file(yaml_file_path)
  end

  def self.log_info(message)
    self.print_log "--- INFO: #{message}", @@executed_script_name
  end

  def self.log_error(message)
    self.print_log "--- ERROR: #{message}", @@executed_script_name
  end

  def self.print_log(message, executed_script_name)
    msg = ''
    unless executed_script_name.nil?
      msg = "--- Script: #{executed_script_name} "
    end
    msg = "#{msg}#{message}"
    puts msg
  end

  def self.print_ruby_version
    self.log_info "=" * 40
    self.log_info "Ruby version: #{`ruby --version`}"
    self.log_info "=" * 40
  end

  # Prints a heading section with the given message
  # @param message [String] The heading message to print
  def self.print_heading(message)
    self.log_info "-"*30
    self.log_info message
    self.log_info "-"*30
  end

  def self.print_script_version
    version_path = File.expand_path('./version.rb', File.dirname(__FILE__))
    file = File.open(version_path, "rb")
    contents = file.read
    v = contents.strip
    self.log_info "="*40
    self.log_info "Automation scripts version: #{v}"
    self.log_info "="*40
  end

  # Execute a command on the command line via ruby
  #
  # @param cmd_string [String] the command to execute on the console
  # @return [Boolean] true if the command returned a status of 0
  def self.execute_command(cmd_string)
    self.log_info "Executing command: #{cmd_string}"
    cmd_output = `#{cmd_string}`
    cmd_return = $?
    puts cmd_output
    cmd_return.success?
  end

  # Executes a command on the command line and returns it's output
  #
  # @param cmd_string [String] the command to execute on the console
  # @return [String] the output of the command
  def self.execute_command_return_output(cmd_string)
    self.log_info "Executing command: #{cmd_string}"
    cmd_output = `#{cmd_string}`
    puts cmd_output
    cmd_output
  end
end
