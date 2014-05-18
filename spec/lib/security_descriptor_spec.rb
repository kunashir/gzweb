require 'spec_helper'
require 'security_descriptor'
require 'base64'

describe SecurityDescriptor do
  SampleBase64SDDL = 'AQAEjBQAAAAwAAAAAAAAADwAAAABBQAAAAAABRUAAADzZS6uQezW6axPh9T0AQAAAQEAAAAAAAEAAAAAAgAwAAIAAAAAEBQAHwAPAAEBAAAAAAABAAAAAAAbFAAfAA8QAQEAAAAAAAEAAAAA'

  context 'default' do
    subject { SecurityDescriptor.new }

    its(:revision) { should == 1 } 
    its(:group) { should be_nil }
    its(:owner) { should be_nil }
    its(:resource_manager_data) { should == 0 }

    it { should be_self_relative }
    it { should_not be_rm_control_valid }
    it { should_not be_sacl_protected }
    it { should_not be_dacl_protected }
    it { should_not be_sacl_auto_inherited }
    it { should_not be_dacl_auto_inherited }
    it { should_not be_sacl_computed_inheritance_required }
    it { should_not be_dacl_computed_inheritance_required }
    it { should_not be_dacl_trusted }
    it { should_not be_server_security }
    it { should_not be_sacl_defaulted }
    it { should_not be_sacl_present }
    it { should_not be_dacl_defaulted }
    it { should_not be_dacl_present }
    it { should_not be_group_defaulted }
    it { should_not be_owner_defaulted }
  end

  it 'should be able to parse base64 sddl' do
    SecurityDescriptor.should respond_to(:from_base64)
  end

  it 'from_base64 should decode base64 string and invoke from_byte_string' do
    Base64.should_receive(:decode64).with("sample").and_return("data")
    SecurityDescriptor.should_receive(:from_byte_string).with("data")
    SecurityDescriptor.from_base64("sample")
  end

  it 'should return descriptor for valid base64 sddl' do
    descriptor = SecurityDescriptor.from_base64(SampleBase64SDDL)
    descriptor.should_not be_nil
    descriptor.should be_instance_of(SecurityDescriptor)
  end

  it 'should have owner property' do
    descriptor = SecurityDescriptor.new
    descriptor.should respond_to(:owner)
    descriptor.should respond_to('owner=')
  end

  it 'by default owner is not set' do
    descriptor = SecurityDescriptor.new
    descriptor.owner.should be_nil
  end

  context 'for sample SDDL' do
    let(:descriptor) { SecurityDescriptor.from_base64(SampleBase64SDDL) }
    subject { descriptor }

    its(:revision) { should == 1 }
    its(:owner) { should == 'S-1-5-21-2922276339-3923176513-3565637548-500'.to_sid }
    its(:group) { should == 'S-1-1-0'.to_sid }
    its(:resource_manager_data) { should == 0 }

    it { should be_self_relative }
    it { should be_dacl_present }
    it { should be_dacl_auto_inherited }
    it { should be_sacl_auto_inherited }
    it { should_not be_owner_defaulted }
    it { should_not be_group_defaulted }
    it { should_not be_dacl_defaulted }
    it { should_not be_sacl_present }
    it { should_not be_sacl_defaulted }
    it { should_not be_sacl_computed_inheritance_required }
    it { should_not be_dacl_computed_inheritance_required }
    it { should_not be_server_security }
    it { should_not be_dacl_trusted }
    it { should_not be_dacl_protected }
    it { should_not be_sacl_protected }
    it { should_not be_rm_control_valid }
  end

  it 'if no owner in SecurityDescriptor it stays nil' do
    sd = SecurityDescriptor.from_byte_string("\x01\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
    sd.owner.should be_nil
  end

  it 'if no group in SecurityDescriptor it stays nil' do
    sd = SecurityDescriptor.from_byte_string("\x01\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
    sd.group.should be_nil
  end

  context 'SDDL validations' do
    it 'should pass minimal SDDL' do
      SecurityDescriptor.from_byte_string("\x01\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00").
        should == SecurityDescriptor.new
      SecurityDescriptor.from_base64("AQAAgAAAAAAAAAAAAAAAAAAAAAA=").
        should == SecurityDescriptor.new
    end
    it 'should check for revision = 1' do
      expect { SecurityDescriptor.from_byte_string("\x00\x00\x00\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.
        to raise_error
    end
    it 'should check that SD is self-relative' do
      expect { SecurityDescriptor.from_byte_string("\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.
        to raise_error
    end
  end
end