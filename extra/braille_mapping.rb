require 'pry'
require 'pry-byebug'

plain_to_braille_map = {
    "a" => "0.....",
    "b" => "0.0...",
    "c" => "00....",
    "d" => "00.0..",
    "e" => "0..0..",
    "f" => "000...",
    "g" => "0000..",
    "h" => "0.00..",
    "i" => ".00...",
    "j" => ".000...",
    "k" => "0...0.",
    "l" => "0.0.0.",
    "m" => "00..0.",
    "n" => "00.00.",
    "o" => "0..00.",
    "p" => "000.0.",
    "q" => "00000.",
    "r" => "0.000.",
    "s" => ".00.0.",
    "t" => ".0000.",
    "u" => "0...00",
    "v" => "0.0.00",
    "w" => ".000.0",
    "x" => "00..00",
    "y" => "00.000",
    "z" => "0..000"
}

number_to_braille_map = {
  
}
#
# class Braille
#
#   def convert(map, message)
#     arr1 = []
#     arr2 = []
#     arr3 = []
# #make a message array using the map hash
# #input map hash and message, output braille string letters
#     message.each_char do |letter|
#       braille = map[letter]
#       next if braille == nil
#       arr1 << braille[0,2]
#       arr2 << braille[2,2]
#       arr3 << braille[4,2]
#     end
#
#     [arr1.join, arr2.join, arr3.join]
#   end
#
# end
# my_braille = Braille.new
# my_braille.convert(plain_to_braille_map, "abcdefg")
