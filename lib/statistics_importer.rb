module StatisticsImporter
  class RowData
    def initialize(row)
      @data = row
    end

    def data_for(attribute)
      data_found = @data[StatisticsHelper.data_import_key(attribute)]
      raise "Could not find data for attribute #{attribute}" if !data_found && !StatisticsHelper.data_is_optional?(attribute)

      data_found
    end
  end
end
