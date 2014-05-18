#encoding: UTF-8

require 'spec_helper'

describe Task do

  context 'default task' do
    subject { Task.new }

    its(:registrator) { should be_nil }
    its(:performer) { should be_nil }
    its(:co_performers) { should be_empty }
    its(:informants) { should be_empty }
    its(:content) { should == "" }
    its(:subject) { should == "Поручение от #{Time.now.strftime('%d.%m.%Y')}" }
    its(:date) { should > Time.now - 1.minutes }
    its(:date) { should < Time.now }
    its(:author) { should be_nil }
    its(:deadline) { should be_nil }
    its(:controller) { should be_nil }
    its(:files) { should be_empty }
  end

  context 'initializing new task' do
    let(:user) { FactoryGirl.create :user }
    subject { Task.new.init(user) }

    its(:registrator) { should == user }
    its(:performer) { should be_nil }
    its(:co_performers) { should be_empty }
    its(:informants) { should be_empty }
    its(:content) { should == "" }
    its(:subject) { should == "Поручение от #{Time.now.strftime('%d.%m.%Y')}" }
    its(:date) { should > Time.now - 1.minutes }
    its(:date) { should < Time.now }
    its(:author) { should == user }
    its(:deadline) { should be_nil }
    its(:controller) { should be_nil }
    its(:files) { should be_empty }
  end
end