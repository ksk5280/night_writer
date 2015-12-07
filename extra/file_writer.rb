class FileWriter
  def write(content)
    File.open(ARGV[1], 'w') {|f| f.puts content }
  end
end
