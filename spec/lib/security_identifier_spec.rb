require 'security_identifier'

describe SecurityIdentifier do

  it 'can create SID using authority and sub-authorities' do
    descriptor = SecurityIdentifier.new(5, 21, 500)
    descriptor.to_s.should == 'S-1-5-21-500'
  end

  it 'SID revision is 1' do
    descriptor = SecurityIdentifier.new(5, 500)
    descriptor.revision.should == 1
  end

  it 'SID authority is stored' do
    descriptor = SecurityIdentifier.new(5, 500)
    descriptor.authority.should == 5
  end

  context 'sample byte string' do
    let(:sample_byte_string) { "\x01\x05\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\xf3\x65\x2e\xae\x41\xec\xd6\xe9\xac\x4f\x87\xd4\xf4\x01\x00\x00" }
    subject { SecurityIdentifier.parse_binary(sample_byte_string) }

    its(:to_s) { should == 'S-1-5-21-2922276339-3923176513-3565637548-500' }
    its(:revision) { should == 1 }
    its(:authority) { should == 5 }
    its(:sub_authorities) { should == [21, 2922276339, 3923176513, 3565637548, 500] }
    its(:binary) { should == sample_byte_string }
    its(:size) { should == 28 }
  end

  context 'embedded byte string' do
    let(:sample_byte_string) { "\x01\x05\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\xf3\x65\x2e\xae\x41\xec\xd6\xe9\xac\x4f\x87\xd4\xf6\x01\x00\x00" }
    let(:container_string) { "\x23\x14\x14\x15" + sample_byte_string + "\x23\x14\x14\x15" }

    subject { SecurityIdentifier.parse_binary(container_string, 4) }

    its(:to_s) { should == 'S-1-5-21-2922276339-3923176513-3565637548-502' }
    its(:revision) { should == 1 }
    its(:authority) { should == 5 }
    its(:sub_authorities) { should == [21, 2922276339, 3923176513, 3565637548, 502] }
    its(:binary) { should == sample_byte_string }
    its(:size) { should == 28 }
  end

  context 'SID validations' do
    it 'should allow minimal correct data' do 
      SecurityIdentifier.parse_binary("\x01\x00\x00\x00\x00\x00\x00\x05").
        should == SecurityIdentifier.new(5)
    end
    it 'should check that revision is 1' do
      expect { SecurityIdentifier.parse_binary("\x00\x00\x00\x00\x00\x00\x00\x05") }.
        to raise_error
    end
    it 'should check that string contains authority' do
      expect { SecurityIdentifier.parse_binary("\x01\x00\x00\x00\x00\x00\x00") }.
        to raise_error
    end
    it 'should check that string contains all sub authorities' do
      expect { SecurityIdentifier.parse_binary("\x01\x01\x00\x00\x00\x00\x10\x45") }.
        to raise_error
      expect { SecurityIdentifier.parse_binary("\x01\x02\x00\x00\x00\x00\x10\x45\x42\x00\x35\x41") }.
        to raise_error
    end
  end

  context 'store as byte string' do
    let(:expected_byte_string) { "\x01\x04\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\xdd\xe4\x01\x00\xb4\x61\xd9\x12\x0a\x02\x00\x00" }
    subject { SecurityIdentifier.new(5, 21, 124125, 316236212, 522)}

    its(:to_s) { should == 'S-1-5-21-124125-316236212-522' }
    its(:revision) { should == 1 }
    its(:authority) { should == 5 }
    its(:sub_authorities) { should == [21, 124125, 316236212, 522] }
    its(:binary) { should == expected_byte_string }
    its(:size) { should == 24 }
  end

  context 'comparable' do
    it 'secirity identifiers are compared by content' do
      SecurityIdentifier.new(5, 500).
        should == SecurityIdentifier.new(5, 500)
      SecurityIdentifier.new(5, 500, 21).
        should == SecurityIdentifier.new(5, 500, 21)
      SecurityIdentifier.new(5, 500).
        should == SecurityIdentifier.parse_binary("\x01\x01\x00\x00\x00\x00\x00\x05\xf4\x01\x00\x00")
      SecurityIdentifier.new(5, 500).
        should_not == SecurityIdentifier.new(5, 502)
      SecurityIdentifier.new(5, 500).
        should_not == SecurityIdentifier.new(4, 500)
      SecurityIdentifier.new(5, 500).
        should_not == SecurityIdentifier.new(5, 500, 21)
      SecurityIdentifier.new(5, 500, 21).
        should_not == SecurityIdentifier.new(5, 500)
    end
  end

  context 'initialization from sid string' do
    it 'can be initialized with string' do
      SecurityIdentifier.new('S-1-5-21-500').
        should == SecurityIdentifier.new(5,21,500)
    end

    it 'string can be converted to sid' do
      'S-1-5-21-500'.to_sid.should == SecurityIdentifier.new(5,21,500)
    end

    context 'sample' do 
      let(:expected_byte_string) { "\x01\x02\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\xf4\x01\x00\x00" }
      subject { 'S-1-5-21-500'.to_sid }

      its(:to_s) { should == 'S-1-5-21-500' }
      its(:revision) { should == 1 }
      its(:authority) { should == 5 }
      its(:sub_authorities) { should == [21, 500] }
      its(:binary) { should == expected_byte_string }
      its(:size) { should == 16 }
    end
  end

end