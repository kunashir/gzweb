require 'spec_helper'

describe TaskList do
	it 'by default task list is empty' do
		TaskList.new.count == 0
	end

  context 'dummy factory' do
    let(:task_info_dummy1) { FactoryGirl.create(:task_info_dummy1) }
    let(:task_info_dummy2) { FactoryGirl.create(:task_info_dummy2) }
    subject { FactoryGirl.create(:task_list_dummy) }

    its(:count) { should == 2 }
    it 'should have dummy1 task info at 0 position' do
      subject[0].should == task_info_dummy1
    end
    it 'should have dummy2 task info at 1st position' do
      subject[1].should == task_info_dummy2
    end
  end

  it 'should generate randomized list when getting for nil employee' do
    TaskInfo.stub(:random).and_return("-random-")

    counts = []

    (0..100).each do
      list = TaskList.get(nil, :performing)

      list.each { |task| task.should == "-random-" }

      list.count.should >= 10
      list.count.should < 50
      counts << list.count unless counts.include? list.count
    end

    counts.length.should > 20 # number of tasks should be randomized
  end

  it 'should query over user task_infos for given folder' do
    user = double("user")
    task_infos = double("task_infos")
    expect(user).to receive(:task_infos) { task_infos }
    expect(task_infos).to receive(:where).with({folder: :performing})

    TaskList.get(user, :performing)
  end

end