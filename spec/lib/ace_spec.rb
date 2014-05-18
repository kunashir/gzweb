require 'ace'
require 'security_identifier'

describe Ace do
  context 'access allowed ace' do
    let(:ace_bytes) { "\x00\x12\x18\x00\x1f\x00\x0f\x00" +
                      "\x01\x02\x00\x00\x00\x00\x00\x05" + 
                      "\x15\x00\x00\x00\xf4\x01\x00\x00" }
    subject { Ace.allowed(0x000f001f, "S-1-5-21-500".to_sid, :inherited, :container_inherit) }

    its(:type) { should == :allowed }
    its(:mask) { should == 0x000f001f }
    its(:sid) { should == "S-1-5-21-500".to_sid }
    its(:flags) { should =~ [:inherited, :container_inherit] }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 24 }
  end

  context 'access allowed ace validations' do
    it 'should check that SID is not nil' do
      expect { Ace.allowed(0x000f001f, nil) }.to raise_error
    end
    it 'should check that SID is SecurityDescriptor' do
      expect { Ace.allowed(0x000f001f, "S-1-5-21-500") }.to raise_error
    end
    it 'should check that flags are ones allowed for ace' do
      expect { Ace.allowed(0x000f001f, "S-1-1-0".to_sid, :ace_trusted) }.to raise_error
    end
  end

  context 'parsing access allowed ace' do
    let(:ace_bytes) {  "\x00\x13\x18\x00\x1f\x00\x0f\x00" +
                       "\x01\x02\x00\x00\x00\x00\x00\x05" + 
                       "\x15\x00\x00\x00\xf4\x01\x00\x00" }
    let(:bytes) { "\x02\x00\x30\x00\x02\x00\x00\x00" + 
                  ace_bytes + 
                  "\x00\x00\x00\x01\x00\x00\x00\x00" }
    subject { Ace.parse_binary(bytes, 8) }

    its(:type) { should == :allowed }
    its(:mask) { should == 0x000f001f }
    its(:sid) { should == "S-1-5-21-500".to_sid }
    its(:flags) { should =~ [:inherited, :container_inherit, :object_inherit] }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 24 }
  end

  context 'access denied ace' do
    let(:ace_bytes) { "\x01\x13\x18\x00\x1f\x00\x0f\x00" +
                      "\x01\x02\x00\x00\x00\x00\x00\x05" + 
                      "\x15\x00\x00\x00\xf4\x01\x00\x00" }
    subject { Ace.denied(0x000f001f, "S-1-5-21-500".to_sid, :inherited, :container_inherit, :object_inherit) }

    its(:type) { should == :denied }
    its(:mask) { should == 0x000f001f }
    its(:sid) { should == "S-1-5-21-500".to_sid }
    its(:flags) { should =~ [:inherited, :container_inherit, :object_inherit] }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 24 }
  end

  context 'access denied ace validations' do
    it 'should check that SID is not nil' do
      expect { Ace.denied(0x000f001f, nil) }.to raise_error
    end
    it 'should check that SID is SecurityDescriptor' do
      expect { Ace.denied(0x000f001f, "S-1-5-21-500") }.to raise_error
    end
    it 'should check that flags are ones allowed for ace' do
      expect { Ace.denied(0x000f001f, "S-1-1-0".to_sid, :inherited, :ace_trusted) }.to raise_error
    end
  end

  context 'parsing access denied ace' do
    let(:ace_bytes) {  "\x01\x11\x18\x00\x1f\x00\x0f\x00" +
                       "\x01\x02\x00\x00\x00\x00\x00\x05" + 
                       "\x15\x00\x00\x00\xf6\x01\x00\x00" }
    let(:bytes) { "\x02\x00\x30\x00\x02\x00\x00\x00" + 
                  ace_bytes + 
                  "\x00\x00\x00\x01\x00\x00\x00\x00" }
    subject { Ace.parse_binary(bytes, 8) }

    its(:type) { should == :denied }
    its(:mask) { should == 0x000f001f }
    its(:sid) { should == "S-1-5-21-502".to_sid }
    its(:flags) { should =~ [:inherited, :object_inherit] }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 24 }
  end

  context 'object access allowed ace' do
    let(:ace_bytes) { "\x05\x12\x3c\x00\x0f\x00\x1f\x00" +
                      "\x02\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x23\xf1\x23\x51" +
                      "\x12\x15\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x01\x02\x00\x00" + 
                      "\x00\x00\x00\x05\x15\x00\x00\x00" + 
                      "\xf4\x01\x00\x00" }
    subject { Ace.allowed_object(0x001f000f, "S-1-5-21-500".to_sid, 0, 0x15125123f123, :inherited, :container_inherit) }

    its(:type) { should == :allowed_object }
    its(:mask) { should == 0x001f000f }
    its(:sid) { should == "S-1-5-21-500".to_sid }
    its(:flags) { should =~ [:inherited, :container_inherit] }
    its(:object_type) { should == 0x00 }
    its(:inherit_object_type) { should == 0x15125123f123 }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 60 }
  end

  context 'object access allowed ace validations' do
    it 'should check that SID is not nil' do
      expect { Ace.allowed_object(0x000f001f, nil, 0, 0) }.to raise_error
    end
    it 'should check that SID is SecurityDescriptor' do
      expect { Ace.allowed_object(0x000f001f, "S-1-5-21-500") }.to raise_error
    end
    it 'should check that flags are ones allowed for ace' do
      expect { Ace.allowed_object(0x000f001f, "S-1-1-0".to_sid, 0, 0, :ace_trusted) }.to raise_error
    end
  end

  context 'parsing object access allowed ace' do
    let(:ace_bytes) { "\x05\x13\x3c\x00\x0f\x00\x2f\x00" +
                      "\x03\x00\x00\x00\x00\x20\x00\x00" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x23\xf1\x23\x51" +
                      "\x12\x15\x40\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x01\x02\x00\x00" + 
                      "\x00\x00\x00\x05\x15\x00\x00\x00" + 
                      "\xf4\x01\x00\x00" }
    let(:bytes) { "\x02\x00\x30\x00\x02\x00\x00\x00" + 
                  ace_bytes + 
                  "\x00\x00\x00\x01\x00\x00\x00\x00" }
    subject { Ace.parse_binary(bytes, 8) }

    its(:type) { should == :allowed_object }
    its(:mask) { should == 0x002f000f }
    its(:sid) { should == "S-1-5-21-500".to_sid }
    its(:flags) { should =~ [:inherited, :container_inherit, :object_inherit] }
    its(:object_type) { should == 0x2000 }
    its(:inherit_object_type) { should == 0x4015125123f123 }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 60 }
  end

  context 'object access denied ace' do
    let(:ace_bytes) { "\x06\x02\x40\x00\x02\x00\x10\x00" +
                      "\x01\x00\x00\x00\xEC\x0D\x0B\xC1" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" +
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x01\x03\x00\x00" + 
                      "\x00\x00\x00\x05\x15\x00\x00\x00" + 
                      "\x40\x00\x00\x00\xf4\x01\x00\x00" }
    subject { Ace.denied_object(0x00100002, "S-1-5-21-64-500".to_sid, 0xC10B0DEC, 0, :container_inherit) }

    its(:type) { should == :denied_object }
    its(:mask) { should == 0x00100002 }
    its(:sid) { should == "S-1-5-21-64-500".to_sid }
    its(:flags) { should =~ [:container_inherit] }
    its(:object_type) { should == 0xC10B0DEC }
    its(:inherit_object_type) { should == 0x00 }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 64 }
  end

  context 'object access denied ace validations' do
    it 'should check that SID is not nil' do
      expect { Ace.denied(0x000f001f, nil) }.to raise_error
    end
    it 'should check that SID is SecurityDescriptor' do
      expect { Ace.denied(0x000f001f, "S-1-5-21-500") }.to raise_error
    end
    it 'should check that flags are ones allowed for ace' do
      expect { Ace.denied(0x000f001f, "S-1-1-0".to_sid, :inherited, :ace_trusted) }.to raise_error
    end
  end

  context 'parsing object access denied ace' do
    let(:ace_bytes) { "\x06\x02\x40\x00\x02\x00\x10\x00" +
                      "\x01\x00\x00\x00\xEC\x0D\x0B\xC1" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x00\x00\x00\x00" +
                      "\x00\x00\x00\x00\x00\x00\x00\x00" + 
                      "\x00\x00\x00\x00\x01\x03\x00\x00" + 
                      "\x00\x00\x00\x05\x15\x00\x00\x00" + 
                      "\x40\x00\x00\x00\xf4\x01\x00\x00" }
    let(:bytes) { "\x02\x00\x30\x00\x02\x00\x00\x00" + 
                  ace_bytes + 
                  "\x00\x00\x00\x01\x00\x00\x00\x00" }
    subject { Ace.parse_binary(bytes, 8) }

    its(:type) { should == :denied_object }
    its(:mask) { should == 0x00100002 }
    its(:sid) { should == "S-1-5-21-64-500".to_sid }
    its(:flags) { should =~ [:container_inherit] }
    its(:object_type) { should == 0xC10B0DEC }
    its(:inherit_object_type) { should == 0x00 }
    its(:binary) { should == ace_bytes }
    its(:size) { should == 64 }
  end

end