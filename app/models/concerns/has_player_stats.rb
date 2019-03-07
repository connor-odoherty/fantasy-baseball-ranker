module HasPlayerStats
  def display(field_name)
    self.send(field_name).display_as(StatisticsHelper.display_type(field_name))
  end
end
