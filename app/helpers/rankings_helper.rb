module RankingsHelper
  def filter_path_for_position(path, position)
    query_symbol = path.include?('?') ? '&' : '?'
    "#{path}#{query_symbol}position=#{position}"
  end

  def sort_by_year(relation, min_year = 2000)
    relation.to_a.select { |x| x.year >= min_year }.sort_by(&:year)
  end

  def sort_by_order_index(relation)
    relation.to_a.sort {|x,y| x.projection_system.order_index <=> y.projection_system.order_index}
  end

  def select_favorite_projection(relation, projection_name = 'steamer')
    relation.to_a.select { |bp| bp.projection_system.slug == projection_name }.first || relation.first
  end
end
