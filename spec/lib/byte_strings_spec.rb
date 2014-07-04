require 'byte_strings'

describe 'Byte strings' do

  describe 'Get low order value' do
    it 'should convert first byte by default' do
      "\x12".get_low_order_value.should == 18
      "\x24".get_low_order_value.should == 36
    end

    it 'should take one byte at given position' do
      "\x12\x20\x04".get_low_order_value(1).should == 32
      "\x12\x20\x04".get_low_order_value(2).should == 4
    end

    it 'should treat further bytes as lower ones' do
      "\x12\x00\x04".get_low_order_value(1, 2).should == 4
      "\x12\x04\x00".get_low_order_value(1, 2).should == (4 << 8)
      "\x12\x00\x00\x00\x00\x00\x05\x21".get_low_order_value(1, 6).should == 5
    end

    it 'should fail if count exceeds string length' do
      expect { "\x00".get_low_order_value(1) }.to raise_error
      expect { "\x00\x01".get_low_order_value(1, 2) }.to raise_error
      expect { "\x00\x01".get_low_order_value(0, 3) }.to raise_error
      expect { "".get_low_order_value }.to raise_error
    end
  end

  describe 'Get high order value' do
    it 'should convert first byte by default' do
      "\x12".get_high_order_value.should == 18
      "\x24".get_high_order_value.should == 36
    end

    it 'should take one byte at given position' do
      "\x12\x20\x04".get_high_order_value(1).should == 32
      "\x12\x20\x04".get_high_order_value(2).should == 4
    end

    it 'should treat further bytes as higher ones' do
      "\x12\x00\x04".get_high_order_value(1, 2).should == (4 << 8)
      "\x12\x04\x00".get_high_order_value(1, 2).should == 4
      "\x12\x00\x00\x00\x00\x00\x05\x21".get_high_order_value(1, 6).should == 5 << (8 * 5)
    end

    it 'should fail if count exceeds string length' do
      expect { "\x00".get_high_order_value(1) }.to raise_error
      expect { "\x00\x01".get_high_order_value(1, 2) }.to raise_error
      expect { "\x00\x01".get_high_order_value(0, 3) }.to raise_error
      expect { "".get_high_order_value }.to raise_error
    end
  end

  describe 'converting to low order byte string' do
    it 'should convert to one byte by default' do
      0x12.to_low_order_byte_string.should == "\x12"
      0x24.to_low_order_byte_string.should == "\x24"
    end

    it 'should treat further bytes as higher ones' do
      (4 << 8).to_low_order_byte_string(2).should == "\x04\x00"
      4.to_low_order_byte_string(2).should == "\x00\x04"
      (5 << (8 * 5)).to_low_order_byte_string(6).should == "\x05\x00\x00\x00\x00\x00" 
      5.to_low_order_byte_string(6).should == "\x00\x00\x00\x00\x00\x05" 
    end

    it 'should ignore values outside byte string length' do
      (0x12 + (0x05 << 8)).to_low_order_byte_string.should == "\x12"
      (0x12 + (0x05 << 8) + (0x84 << 16)).to_low_order_byte_string(2).should == "\x05\x12"
    end
  end

  describe 'converting to high order byte string' do
    it 'should convert to one byte by default' do
      0x12.to_high_order_byte_string.should == "\x12"
      0x24.to_high_order_byte_string.should == "\x24"
    end

    it 'should treat further bytes as higher ones' do
      (4 << 8).to_high_order_byte_string(2).should == "\x00\x04"
      4.to_high_order_byte_string(2).should == "\x04\x00"
      (5 << (8 * 5)).to_high_order_byte_string(6).should == "\x00\x00\x00\x00\x00\x05" 
      5.to_high_order_byte_string(6).should == "\x05\x00\x00\x00\x00\x00" 
    end

    it 'should ignore values outside byte string length' do
      (0x12 + (0x05 << 8)).to_high_order_byte_string.should == "\x12"
      (0x12 + (0x05 << 8) + (0x84 << 16)).to_high_order_byte_string(2).should == "\x12\x05"
    end
  end
end