#!/usr/bin/ruby
require_relative 'file_handler'
require_relative 'plain_to_braille_map'
require_relative 'number_to_braille_map'
require_relative 'contraction_map'
require 'pry'
require 'pry-byebug'

class NightWriter
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

  def encode_file_to_braille
    plain_message = file_handler.read
    braille = encode_to_braille(plain_message)
    puts "  Created #{file_handler.write_file.inspect} containing #{braille.length/3} characters"
    output_message_to_file(braille)
  end

  def encode_to_braille(plain_message)
    number_switch = false

    plain_message.each_char do |character|
      is_number = character =~/[0-9]/;
      is_caps = character =~ /[A-Z]/;

      if is_number && !number_switch
        number_switch = true
        add_braille_to_lines(plain_to_braille_map["#"])
      elsif !is_number
        number_switch = false
      end

      if is_caps
        character = character.downcase
        add_braille_to_lines(add_shift_for_capital_letters)
      end

      if number_switch
        add_braille_to_lines(number_character_conversion(character))
      else
        add_braille_to_lines(plain_character_conversion(character))
      end
    end
    new_line(80)
  end

  def add_braille_to_lines(braille_char)
    lines[0] += braille_char[0,2]
    lines[1] += braille_char[2,2]
    lines[2] += braille_char[4,2]
  end

  def plain_character_conversion(letter)
    plain_to_braille_map[letter] || plain_to_braille_map["unknown"]
  end

  def number_character_conversion(number)
    number_to_braille_map[number]
  end

  def add_shift_for_capital_letters
    plain_to_braille_map["shift"]
  end

  def new_line(line_length)
    string_output = ""
    while lines[0].length > 0
      string_output += lines[0].slice!(0, 80) + "\n"
      string_output += lines[1].slice!(0, 80) + "\n"
      string_output += lines[2].slice!(0, 80) + "\n"
    end
    string_output.chomp
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
  night_writer = NightWriter.new(ARGV[0] || "message.txt", ARGV[1] || "braille.txt")
  night_writer.encode_file_to_braille
  # night_writer.encode_file_to_plain
end
