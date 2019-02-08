class ProRankingSetController < ApplicationController
  before_action :set_pro_ranking_set, only: [:show]

  def show

  end

  private

  def set_pro_ranking_set
    @pro_ranking_set = ProRankingSet.find(params[:id])
  end
end
