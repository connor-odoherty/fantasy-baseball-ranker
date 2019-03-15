# frozen_string_literal: true

module ApplicationHelper
  def position_breadcrumbs(page_name, position, action)
    breadcrumbs = "<div class='position-breadcrumbs-text col-xs-6 text-left'><span class='strong'>#{page_name} > </span><span>#{position.to_s.titlecase}</span>"
    breadcrumbs += ' (edit)' if action == :edit
    breadcrumbs += '</div>'
    raw breadcrumbs
  end
end
