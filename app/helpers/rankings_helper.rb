module RankingsHelper
  def filter_path_for_position(path, position)
    query_symbol = path.include?('?') ? '&' : '?'
    "#{path}#{query_symbol}position=#{position}"
  end

  def sort_by_year(relation, min_year = 2000)
    relation.to_a.select { |x| x.year >= min_year }.sort_by(&:year)
  end
end
