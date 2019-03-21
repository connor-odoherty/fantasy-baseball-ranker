module UserRankingSetsSidebarHelper
  def position_is_selected(position, on_page)
    on_page && @position_filter == position
  end
end
