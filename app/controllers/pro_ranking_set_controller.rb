class ProRankingSetController < ApplicationController
  before_action :set_pro_ranking_set, only: [:show]
  before_action :set_position_filer, only: [:show]
  before_action :set_players, only: [:show]

  def show; end

  private

  def set_pro_ranking_set
    @pro_ranking_set = ProRankingSet.includes(pro_ranking_players: {
                                                player: [:mlb_team]
                                              }).find(params[:id])
  end

  def set_position_filer
    if filter_params[:position].present? && filter_params[:position] != 'all'
      @position_filter = filter_params[:position].to_sym
    else
      @position_filter = :all
    end
  end

  def set_players
    @players = ProRankingPlayer.includes(player: [:mlb_team].where(pro_ranking_set: @pro_ranking_set).rank(:ovr_rank).to_a
    if @position_filter != :all
      @players = @players.select do |pro_ranking_player|
        pro_ranking_player.player.positions?(@position_filter)
      end
    end
  end

  def filter_params
    params.permit(:position)
  end
end
