class String
  def get_low_order_value(start = 0, count = 1)
    count = 1 if count < 1
    start.upto(start + count - 1).
      reduce(0) { |result, index| (result << 8) + getbyte(index) }
  end

  def get_high_order_value(start = 0, count = 1)
    count = 1 if count < 1
    start.upto(start + count - 1).
      reduce(0) { |result, index| result + (getbyte(index) << (8 * (index - start))) }
  end
end

class Integer
  def to_low_order_byte_string(size = 1)
    size = 1 if size < 1
    0.upto(size - 1).
      reduce("") { |result, index|  (self >> (index * 8) & 0xFF).chr + result }
 end

  def to_high_order_byte_string(size = 1)
    size = 1 if size < 1
    0.upto(size - 1).
      reduce("") { |result, index|  result + (self >> (index * 8) & 0xFF).chr }
  end
end