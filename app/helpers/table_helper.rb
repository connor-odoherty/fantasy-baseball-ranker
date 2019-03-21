module TableHelper
  def per_page_select_dropdown
    select_tag 'per_page_select', options_for_select([10, 20, 30, 50, 75, 100, 200].map {|val| [val, val]}, @per_page), class: 'form-control'
  end
end
