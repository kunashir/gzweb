class CacheBase < ActiveRecord::Base
  self.abstract_class = true
  # if "#{Rails.env}" =~ /_cache$/
  #   establish_connection "#{Rails.env}"
  # else
  #   establish_connection "#{Rails.env}_cache"
  # end
end