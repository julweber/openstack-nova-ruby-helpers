require 'csv'

class NovaHelper
  def self.write_csv_from_output(nova_output, file_name)
    lines = nova_output.split("\n")
    lines.delete_at(2)
    lines.delete_at(0)
    lines.delete_at(lines.count-1)

    puts "Writing to file: #{file_name}"
    CSV.open(file_name, "wb") do |csv|
      lines.each do |line|
        line = line[2..-2]
        csv << line.split("|")
      end
    end
  end
end
