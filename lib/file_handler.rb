require 'pry'

class FileHandler
  attr_reader :read_file
  attr_reader :write_file

  def initialize(read_file, write_file)
    # abort("no read file \"#{read_file}\"") unless File.exist?(read_file)
    # abort("no write file \"#{write_file}\"") unless File.exist?(write_file)
    # abort("can't write to file \"#{write_file}\"") unless File.writable?(write_file)
    @read_file = read_file
    @write_file = write_file
  end

  def read
    File.read(read_file).chomp
  end

  def write(message)
    File.open(write_file, 'w') {|f| f.puts message }
  end
end
