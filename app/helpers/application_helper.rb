# frozen_string_literal: true

module ApplicationHelper
  def position_breadcrumbs(page_name, position, action)
    breadcrumbs = "<div class='position-breadcrumbs-text col-xs-6 text-left'><span class='strong'>#{page_name} > </span><span>#{position.to_s.titlecase}</span>"
    breadcrumbs += ' (edit)' if action == :edit
    breadcrumbs += '</div>'
    raw breadcrumbs
  end

  def current_action?(query_name)
    action_name == query_name
  end

  def current_controller?(query_name)
    controller_name == query_name
  end

  def fg_player_link(player)
    raw "<a class='fg-player-link' target='_blank' href='#{player.fg_link}'>#{player.display_name}</a>"
  end
end
