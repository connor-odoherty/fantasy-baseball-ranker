class UserRankingSetsLayoutController < ApplicationController
  before_action :add_sidebar

  private

  def add_sidebar
    @responsive_sidebar_content = 'layouts/user_ranking_sets_sidebar'
    @responsive_sidebar_menu_name = 'Ranking'
    @responsive_sidebar_content_class = 'user-ranking-sidebar'
  end
end
