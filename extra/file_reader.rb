require 'pry'

class FileReader
  # attr_reader :message

  def read
    filename = ARGV[0]
    body = File.read(filename)
    puts "  Created #{ARGV[1].inspect} containing #{body.inspect.length} characters"
    puts "Message says #{body.inspect}"
  end

end

class FileWriter
  def write(content)
    File.open(ARGV[1], 'w') {|f| f.puts content }
  end
end


# From Josh's example:
# filename = ARGV[0]
# if File.file? filename
#   body = File.read(filename)
#   puts "  Created #{ARGV[1].inspect} containing #{body.inspect.length} characters"
# end
#
# File.open(ARGV[1], 'w') {|f| f.puts "Hello World" }
