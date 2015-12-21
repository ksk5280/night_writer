#!/usr/bin/ruby
require_relative 'file_handler'
require_relative 'plain_to_braille_map'
require_relative 'number_to_braille_map'
require_relative 'contraction_map'
require_relative 'night_writer'

class NightReader
  attr_reader :file_handler
  attr_reader :plain_to_braille_map
  attr_reader :braille_to_plain_map
  attr_reader :number_to_braille_map
  attr_accessor :lines

  def initialize(read_file, write_file)
    @file_handler = FileHandler.new(read_file, write_file)
    @plain_to_braille_map = PlainToBrailleMap.encoder
    @braille_to_plain_map = PlainToBrailleMap.encoder.invert
    @number_to_braille_map = NumberToBrailleMap.encoder
    @lines = [ "", "", "" ]
  end

  def encode_file_to_plain
    braille_message = file_handler.read
    plain_message = encode_to_plain(braille_message)
    puts "  Created #{file_handler.write_file.inspect} containing #{plain_message.length} characters"
    output_message_to_file(plain_message)
  end

  def encode_to_plain(braille_message)
    braille_array = braille_message.split
    if braille_array.length > 3
      index = 3
      while braille_array.length > index
        if index % 3 == 0
          braille_array[0] += braille_array[index]
        elsif index % 3 == 1
          braille_array[1] += braille_array[index]
        elsif index % 3 == 2
          braille_array[2] += braille_array[index]
        end
        index += 1
      end
      braille_array = braille_array.take(3)
    end

    plain_message = ""
    while braille_array[0].length > 0
      braille_character = ""
      braille_array.each do |string|
        braille_character += string.slice!(0,2)
      end
      if plain_message.slice(-5,5) == "shift"
        plain_message.slice!(-5,5)
        plain_message += braille_character_conversion(braille_character).upcase
      else
        plain_message += braille_character_conversion(braille_character)
      end
    end
    plain_message
  end

  def braille_character_conversion(braille_character)
    braille_to_plain_map[braille_character] || "X"
  end

  def output_message_to_file(output)
    file_handler.write(output)
  end
end

if __FILE__ == $0
  night_reader = NightReader.new(ARGV[0] || "braille.txt", ARGV[1] || "output_message.txt")
  night_reader.encode_file_to_plain
end
