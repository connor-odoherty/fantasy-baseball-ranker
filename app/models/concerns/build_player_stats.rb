module BuildPlayerStats
  # needs to be from StatisticsImporter::RowData.new(row)
  def build_from_row_data(row_data)
    stat_fields.each { |field_name| self[field_name] = row_data.data_for(field_name) }
  end
end
