module RankingsHelper
  def filter_path_for_position(path, position)
    query_symbol = path.include?('?') ? '&' : '?'
    "#{path}#{query_symbol}position=#{position}"
  end
end