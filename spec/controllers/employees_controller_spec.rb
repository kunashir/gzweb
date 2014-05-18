#encoding: UTF-8

require 'spec_helper'

describe EmployeesController do
  set_user_logged_in

  context 'Searching for employees' do

    it 'should respond to find method' do
      get :find, filter: '_'
      response.status.should == 200
    end

    it 'should check that term parameter is passed' do
      get :find
      response.status.should == 400
      response.body.should == { error: "Search term is not specified" }.to_json
    end

    it 'should request TakeOffice::Employees.search to perform search' do
      TakeOffice::Employee.should_receive(:search).
        with('<search-str>').
        and_return([])

      get :find, filter: '<search-str>'
    end

    it 'should render TakeOffice::Employee.search results back to json' do
      TakeOffice::Employee.stub(:search).
        with('term').
        and_return([ 
            TakeOffice::Employee.new(RowID: 'row-id', DisplayString: 'Hello'), 
            TakeOffice::Employee.new(RowID: 'id-other', DisplayString: 'World')])
      get :find, filter: 'term'
      response.status.should == 200
      response.body.should == 
        { employees: [
         { id: 'row-id', name: 'Hello'}, 
         { id: 'id-other', name: 'World' } ]
        }.to_json
    end
  end

end