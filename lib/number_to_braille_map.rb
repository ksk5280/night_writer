class NumberToBrailleMap
  def self.encoder
    {
      "1" => "0.....",
      "2" => "0.0...",
      "3" => "00....",
      "4" => "00.0..",
      "5" => "0..0..",
      "6" => "000...",
      "7" => "0000..",
      "8" => "0.00..",
      "9" => ".00...",
      "0" => ".000..",
    }
  end
end
