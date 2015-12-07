require 'minitest'
require 'night_writer'

class NightWriterTest < Minitest::Test
  attr_reader :input_file, :output_file
  @input_file = ARGV[0] || "message.txt"
  @output_file = ARGV[1] || "braille.txt"

  def test_can_write_braille_a
    my_braille = NightWriter.new(input_file, output_file)
    a = my_braille.encode_to_braille("a")
    assert_equal a, "0.\n..\n.."
  end

  def test_can_write_braille_ab
    my_braille = NightWriter.new(input_file, output_file)
    ab = my_braille.encode_to_braille("ab")
    assert_equal ab, "0.0.\n..0.\n...."
  end

  def test_can_write_braille_a_b
    my_braille = NightWriter.new(input_file, output_file)
    a_b = my_braille.encode_to_braille("a b")
    assert_equal a_b, "0...0.\n....0.\n......"
  end

  def test_can_write_braille_capital_letter_A
    my_braille = NightWriter.new(input_file, output_file)
    capital_a = my_braille.encode_to_braille("A")
    assert_equal capital_a, "..0.\n....\n.0.."
  end

  def test_can_write_braille_letters_X_yZ
    my_braille = NightWriter.new(input_file, output_file)
    capital_x_yz = my_braille.encode_to_braille("X yZ")
    assert_equal capital_x_yz, "..00..00..0.\n.......0...0\n.000..00.000"
  end

  def test_can_write_braille_80_chars_wide
    my_braille = NightWriter.new(input_file, output_file)
    long_message = my_braille.encode_to_braille("This is a really long message to write to braille")
    assert_equal long_message, "...00..0.0...0.0..0...0.0.0.0.0.00..0.0.0000..000..0.00.000....00....00..0.00...\n..00000.0...0.0.......00.0..0.0..0..0..0.000.....00.0...00.0..00.0..00000.00.0..\n.00.....0.....0.......0.....0.0.00..0.0.0.....0...0.0.........0.0....00...0.....\n.00...0.0.0..00.0.0.\n00.0..0.00..0.0.0..0\n0.0.....0.....0.0..."
  end

  def test_can_write_braille_all_char
    my_braille = NightWriter.new(input_file, output_file)
    all_char = my_braille.encode_to_braille(" !',-.?")
    assert_equal all_char, "..............\n..00..0...000.\n..0.0...00.000"
  end

  def test_can_write_braille_numbers
    my_braille = NightWriter.new(input_file, output_file)
    nums123 = my_braille.encode_to_braille("123")
    assert_equal nums123, ".00.0.00\n.0..0...\n00......"
  end

  def test_can_write_braille_numbers_then_letters
    my_braille = NightWriter.new(input_file, output_file)
    nums123_def = my_braille.encode_to_braille("123 def")
    assert_equal nums123_def, ".00.0.00..000.00\n.0..0......0.00.\n00.............."
  end

  def test_can_write_plain_from_braille_hello_world
    my_braille = NightWriter.new(input_file, output_file)
    hello_world = my_braille.encode_to_plain("0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...")
    assert_equal hello_world, "hello world"
  end

  def test_can_write_caps_plain_from_braille_ABC
    my_braille = NightWriter.new(input_file, output_file)
    abc = my_braille.encode_to_plain("..0...0...00\n......0.....\n.0...0...0..")
    assert_equal abc, "ABC"
  end

  def test_can_write_braille_to_file
    my_braille = NightWriter.new("test/fixtures/message_test.txt","test/braille_test.txt")
    my_braille.encode_file_to_braille
    file_output = File.read("test/fixtures/braille_test.txt").chop

    assert_equal file_output, "0.\n..\n.."
  end
end
