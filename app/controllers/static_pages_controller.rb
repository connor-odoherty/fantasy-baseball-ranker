# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :set_pro_ranking_sets
  before_action :set_user_ranking_sets

  def home; end

  def help; end

  private

  def set_pro_ranking_sets
    @pro_ranking_sets = ProRankingSet.all
  end

  def set_user_ranking_sets
    @user_ranking_sets = current_user.user_ranking_sets if current_user.present?
  end
end
