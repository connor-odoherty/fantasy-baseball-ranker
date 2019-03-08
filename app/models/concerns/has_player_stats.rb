module HasPlayerStats
  def display(field_name)
    return '-' unless has_attribute? field_name

    send(field_name)&.display_as(StatisticsHelper.display_type(field_name))
  end
end
