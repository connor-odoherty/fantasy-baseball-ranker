class UserRankingSetsController < ApplicationController
  before_action :set_position_filer, only: %i[show edit update]
  before_action :set_user_ranking_set, except: %i[index new create]
  before_action :set_user_ranking_players, only: %i[show edit update]

  def index
    if current_user.user_ranking_sets.any?
      redirect_to user_ranking_set_path(current_user.user_ranking_sets.order(updated_at: :desc).first)
    else
      redirect_to new_user_ranking_set_path
    end
  end

  def show; end

  def new
    @new_user_ranking_set = current_user.user_ranking_sets.build
  end

  def create
    @new_user_ranking_set = current_user.user_ranking_sets.build(user_ranking_set_params)
    if @new_user_ranking_set.save
      if associate_default_rankings_with_new_ranking_set
        redirect_to @new_user_ranking_set
      else
        redirect_to new_user_ranking_set_path
      end
    else
      redirect_to new_user_ranking_set_path
    end
  end

  def edit; end

  def update
    ovr_rank_list = []
    user_ranking_set_params[:user_ranking_players_attributes].each do |_k, user_ranking_player_params|
      ovr_rank_list.push(user_ranking_player_params[:ovr_rank])
    end

    ovr_rank_list.sort_by!(&:to_i)
    new_params = user_ranking_set_params
    cur_index = 0
    new_params[:user_ranking_players_attributes].each do |_k, user_ranking_player_params|
      user_ranking_player_params[:ovr_rank] = ovr_rank_list[cur_index]
      cur_index += 1
    end

    @user_ranking_set.assign_attributes(new_params)
    @user_ranking_set.updated_at = DateTime.now
    if @user_ranking_set.save
      redirect_to user_ranking_set_path(@user_ranking_set, position: @position_filter)
    else
      render :edit
    end
  end

  def sort
    # params[:user_ranking_player].each_with_index do |id, index|
    #   @user_ranking_set.where(id: id).update_all(position: index)
    #   @user_ranking_set.where(id: id).update_all(position: index)
    # end
    #
    # head :ok
  end

  def destroy
    @user_ranking_set.destroy
    flash[:success] = 'Ranking deleted'
    redirect_to new_user_ranking_set_path
  end

  private

  def set_position_filer
    @position_filter = if filter_params[:position].present?
                         filter_params[:position].to_sym
                       else
                         :catcher
                       end
    @for_batting = false
    @for_pitching = false
    if @position_filter == :all
      @for_batting = true
      @for_pitching = true
    elsif [:starting_pitcher, :relief_pitcher].include? @position_filter
      @for_pitching = true
    else
      @for_batting = true
    end
  end

  def user_ranking_set_params
    pp 'PARAMS', params
    params.require(:user_ranking_set).permit(:id, :ranking_name,
                                             user_ranking_players_attributes: %i[id ovr_rank])
  end

  def set_user_ranking_set
    @user_ranking_set = current_user.user_ranking_sets.find(params[:id])
  end

  def set_user_ranking_players
    if @position_filter == :all
      @user_ranking_players = @user_ranking_set.user_ranking_players.limit(300).includes(user_player:
                                                                              [:user_player_articles,
                                                                               player: [:mlb_team,
                                                                                        :season_batting_lines,
                                                                                        :season_pitching_lines,
                                                                                        batting_projections: [:projection_system],
                                                                                        pitching_projections: [:projection_system]]]).references(user_player: :player).order(ovr_rank: :asc)
    else
      @user_ranking_players = @user_ranking_set.user_ranking_players
                                               .where('players.positions & ? > 0', Player.bitmask_for_positions(@position_filter))
                                               .includes(user_player:
                                                [:user_player_articles,
                                                 player: [:mlb_team,
                                                          :season_batting_lines,
                                                          :season_pitching_lines,
                                                          batting_projections: [:projection_system],
                                                          pitching_projections: [:projection_system]]]).references(user_player: :player).order(ovr_rank: :asc)
    end
  end

  def associate_default_rankings_with_new_ranking_set
    elo_start_point = 2100
    source_ranking_set = nfbc_ranking_set
    ovr_rank_count = 1
    user_ranking_players_values = []
    source_ranking_set.pro_ranking_players.find_each do |pro_ranking_player|
      user_player = current_user.user_players.find_by(player_id: pro_ranking_player.player_id)
      user_player = current_user.user_players.create!(player_id: pro_ranking_player.player_id) unless user_player.present?

      next if !user_player.id.present? || !@new_user_ranking_set.id.present? || !ovr_rank_count.present? || !(elo_start_point - pro_ranking_player.ovr_rank).present?

      user_ranking_players_values.push "(#{user_player.id},#{@new_user_ranking_set.id},#{ovr_rank_count},#{elo_start_point - pro_ranking_player.ovr_rank})"
      ovr_rank_count += 1

      # new_user_ranking_player = @new_user_ranking_set.user_ranking_players.create(
      #   user_player: user_player,
      #   ovr_rank: ovr_rank_count,
      #   elo_score: (elo_start_point - pro_ranking_player.ovr_rank)
      # )
      # next if new_user_ranking_player
      #
      # source_ranking_set.destroy_all
      # source_ranking_set.errors.add(:pro_ranking_players, 'failed to save properly')
      # return false
    end
    values = user_ranking_players_values.join(',')
    ActiveRecord::Base.connection.execute("INSERT INTO user_ranking_players (user_player_id, user_ranking_set_id, ovr_rank, elo_score) VALUES #{values}")
    true
  end

  def nfbc_ranking_set
    ProRankingSet.find('nfbc-february-adp')
  end

  def filter_params
    params.permit(:position)
  end
end
