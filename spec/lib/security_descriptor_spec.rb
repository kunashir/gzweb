require 'spec_helper'
require 'security_descriptor'
require 'base64'

module SDDL

  describe SecurityDescriptor do
    SampleBase64SDDL = 'AQAEjBQAAAAwAAAAAAAAADwAAAABBQAAAAAABRUAAADzZS6uQezW6axPh9T0AQAAAQEAAAAAAAEAAAAAAgAwAAIAAAAAEBQAHwAPAAEBAAAAAAABAAAAAAAbFAAfAA8QAQEAAAAAAAEAAAAA'

    context 'default' do
      subject { SecurityDescriptor.new }

      its(:revision) { should == 1 } 
      its(:group) { should be_nil }
      its(:owner) { should be_nil }
      its(:resource_manager_data) { should == 0 }

      it { should be_self_relative }
      it { should_not be_dacl_present }
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

    it 'owner can be set' do
      descriptor = SecurityDescriptor.new
      descriptor.owner = 'S-1-5-21-412312'.to_sid
      descriptor.owner.should == 'S-1-5-21-412312'.to_sid
    end

    it 'can be converted to base64 binary form' do
      descriptor = SecurityDescriptor.new
      descriptor.should respond_to('to_base64')
      descriptor.to_base64.should == 'AQAAgAAAAAAAAAAAAAAAAAAAAAA='
    end

    it 'saves changed owner to simple base64 binary form' do
      descriptor = SecurityDescriptor.new
      descriptor.owner = 'S-1-5-21-34123'.to_sid
      descriptor.to_byte_string.should == 
        "\x01\x00\x00\x80\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x02\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\x4b\x85\x00\x00"
      descriptor.to_base64.should == 'AQAAgBQAAAAAAAAAAAAAAAAAAAABAgAAAAAABRUAAABLhQAA'
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

    context 'for default SDDL' do
      let(:defaultSDDL) { 'AQAEgAAAAAAAAAAAAAAAABQAAAACAAgAAAAAAA==' } 
      let(:descriptor) { SecurityDescriptor.from_base64(defaultSDDL) }
      subject { descriptor }
      
      its(:revision) { should == 1 }

      its(:owner) { should be_nil }
      its(:group) { should be_nil }
      its(:resource_manager_data) { should == 0 }

      it { should be_self_relative }
      it { should be_dacl_present }
      it { should_not be_dacl_auto_inherited }
      it { should_not be_sacl_auto_inherited }
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

    context 'changing owner in real SID' do
      let(:initial_SID64) { 'AQAEjBQAAAAwAAAAAAAAADwAAAABBQAAAAAABRUAAAAXvDR1BDypZHkoBVD0AQAAAQEAAAAAAAEAAAAAAgAwAAIAAAAAEBQAHwAPAAEBAAAAAAABAAAAAAAbFAAfAA8QAQEAAAAAAAEAAAAA' }
      let(:target_SID64) { 'AQAEjBQAAAAwAAAAAAAAADwAAAABBQAAAAAABRUAAADzZS6uQezW6axPh9T0AQAAAQEAAAAAAAEAAAAAAgAwAAIAAAAAEBQAHwAPAAEBAAAAAAABAAAAAAAbFAAfAA8QAQEAAAAAAAEAAAAA' }
      let(:target_owner) { 'S-1-5-21-2922276339-3923176513-3565637548-500'.to_sid }
      let(:another_target_SID64) { 'AQAEjBQAAAAwAAAAAAAAADwAAAABBQAAAAAABRUAAADzZS6uQezW6axPh9QBBAAAAQEAAAAAAAEAAAAAAgAwAAIAAAAAEBQAHwAPAAEBAAAAAAABAAAAAAAbFAAfAA8QAQEAAAAAAAEAAAAA' }
      let(:another_target_owner) { 'S-1-5-21-2922276339-3923176513-3565637548-1025'.to_sid }

      let(:initial_sd) { SecurityDescriptor.from_base64(initial_SID64) }
      subject { initial_sd }

      its(:dacl) { should == "\x02\x00\x30\x00\x02\x00\x00\x00\x00\x10\x14\x00\x1F\x00\x0F\x00\x01\x01\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x1b\x14\x00\x1F\x00\x0F\x10\x01\x01\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00" }
      its(:to_base64) { should == initial_SID64 }

      it 'after owner change mutates to target SID' do
        subject.owner = target_owner
        subject.to_base64.should == target_SID64
      end

      it 'after another owner change mutates to another target SID' do
        subject.owner = another_target_owner
        subject.to_base64.should == another_target_SID64
      end

    end
  end

end