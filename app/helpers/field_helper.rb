require 'take_office/employee'

module FieldHelper

  def row(field_descriptor, options = {})
    field_class = "row"
    field_class += " " + options[:class] unless options[:class].nil?
    if options[:label].nil?
      raw <<-html
        <div class="#{field_class}">
          <div class="field-value">
            #{field_descriptor.field}
          </div>
        </div>
      html
    else
      raw <<-html
        <div class="#{field_class}">
          <label for="#{field_descriptor.id}">#{t(options[:label])}:</label>
          <div class="field-value">
            #{field_descriptor.field}
          </div>
        </div>
      html
    end
  end

  def employee_select(object, object_name, property)
    #object_name = model_name_from_record_or_class(object).param_key
    EmployeeFieldDescriptor.new(object, object_name, property)
  end

  def employees_select(object, object_name, property)
    #object_name = model_name_from_record_or_class(object).param_key
    EmployeesFieldDescriptor.new(object, object_name, property)
  end

  def text_edit(object, object_name, property)
    #object_name = model_name_from_record_or_class(object).param_key
    TextEditFieldDescriptor.new(object, object_name, property)
  end

  def datetime_edit(object, object_name, property)
    #object_name = model_name_from_record_or_class(object).param_key
    DateTimeFieldDescriptor.new(object, object_name, property)
  end

  class EmployeeFieldDescriptor
    def initialize(object, object_name, property_name)
      @object = object
      @object_name = object_name
      @property_name = property_name
    end

    def id
      "#{@object_name}-#{@property_name}"
    end

    def employee
      return nil if @object.nil?
      @object.send(@property_name)
    end

    def value
      return "" if employee.nil? 
      return employee.display_name if employee.is_a? TakeOffice::Employee
      return ""
    end

    def value_id
      return "" if employee.nil?
      return employee.id if employee.is_a? TakeOffice::Employee
      return ""
    end

    def field
      <<-html
        <input id="#{id}" 
          value="#{value}" 
          class="edit-lookup-multi"
          spellcheck="false" 
          data-id="#{value_id}"
          data-text="#{value}"
          data-lookup="/employees/find" 
          data-lookup-term="filter"
          data-lookup-single="true" />
      html
    end
  end

  class EmployeesFieldDescriptor
    def initialize(object, object_name, property_name)
      @object = object
      @object_name = object_name
      @property_name = property_name
    end

    def id
      "#{@object_name}-#{@property_name}"
    end

    def employee
      return nil if @object.nil?
      @object.send(@property_name)
    end

    def value
      return "" if employee.nil? 
      return employee.display_name if employee.is_a? TakeOffice::Employee
      return ""
    end

    def value_id
      return "" if employee.nil?
      return employee.id if employee.is_a? TakeOffice::Employee
      return ""
    end

    def field
      <<-html
        <input id="#{id}" 
          value="#{value}" 
          class="edit-lookup-multi"
          spellcheck="false" 
          data-id="#{value_id}"
          data-text="#{value}"
          data-lookup="/employees/find" 
          data-lookup-term="filter" />
      html
    end
  end

  class TextEditFieldDescriptor
    def initialize(object, object_name, property_name)
      @object = object
      @object_name = object_name
      @property_name = property_name
    end

    def id
      "#{@object_name}-#{@property_name}"
    end

    def field
      "<textarea id=\"#{id}\"></textarea>"
    end
  end

  class DateTimeFieldDescriptor
    def initialize(object, object_name, property_name)
      @object = object
      @object_name = object_name
      @property_name = property_name
    end

    def id
      "#{@object_name}-#{@property_name}"
    end

    def field
      "<input id=\"#{id}\" class=\"date-picker\"/><div class=\"date-picker\"></div>"
    end
  end

end