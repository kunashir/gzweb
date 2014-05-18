require 'acl'

describe ACL do
  context 'default' do
  end

  context 'sample' do
    let(:bytes) { "\x02\x00\x30\x00\x02\x00\x00\x00" +
                  "\x00\x10\x14\x00\x1f\x00\x0f\x00" +
                  "\x01\x01\x00\x00\x00\x00\x00\x01" + 
                  "\x00\x00\x00\x00\x00\x1b\x14\x00" +
                  "\x1f\x00\x0f\x10\x01\x01\x00\x00" +
                  "\x00\x00\x00\x01\x00\x00\x00\x00" }
    let(:aces) { [ Ace.allowed(0x000f001f, "S-1-1-0".to_sid, [:inherited_ace]),
                   Ace.allowed(0x100f001f, "S-1-1-0".to_sid, [:inherited_ace, :inherit_only_ace, :container_inherit_ace, :object_inherit_ace]) ] }

    subject { ACL.from_byte_string(bytes) }

    its(:revision) { should == 2 }
    its(:aces) { should == aces }
  end
end