#encoding: UTF-8

require 'spec_helper'

describe User do
  context 'by default' do
    subject { User.new }

    its(:id) { should be_nil }
    its(:first_name) { should be_nil }
    its(:last_name) { should be_nil }
    its(:display_name) { should be_nil }
  end

  its 'to_s should return display_name' do
    u = User.new
    u.should_receive(:display_name).and_return("-тестовое-значение-")
    u.to_s.should == "-тестовое-значение-"
  end
end
