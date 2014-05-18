module ApplicationHelper

  def date_format
    "%d.%m.%Y"
  end

  def date_time_format
    "%d.%m.%Y %H:%M"
  end

  def format_value_for_table(value, format)
    return value.strftime(format) if value.is_a? Time
    value
  end
end