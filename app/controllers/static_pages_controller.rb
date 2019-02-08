# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :set_pro_ranking_sets

  def home

  end

  def help; end

  private

  def set_pro_ranking_sets
    @pro_ranking_sets = ProRankingSet.all
  end
end
