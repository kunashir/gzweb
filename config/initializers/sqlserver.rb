#необходимо для прохождения тестов
module ActiveRecord
  module ConnectionAdapters
    class ColumnDefinition 
      def self.string_to_binary(value)
        SQLServerColumn.string_to_binary(value)
              # "0x#{value.unpack("H*")[0]}"
      end
    end
  end
end

