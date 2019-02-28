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
    @position_filter = if filter_params[:position].present? && filter_params[:position] != 'all'
                         filter_params[:position].to_sym
                       else
                         :all
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
    @user_ranking_players = @user_ranking_set.user_ranking_players.order(ovr_rank: :asc).to_a
    if @position_filter != :all
      @user_ranking_players = @user_ranking_players.select do |user_ranking_player|
        user_ranking_player.user_player.player.positions?(@position_filter)
      end
    end
  end

  def associate_default_rankings_with_new_ranking_set
    elo_start_point = 2100
    source_ranking_set = nfbc_ranking_set
    ovr_rank_count = 1
    source_ranking_set.pro_ranking_players.find_each do |pro_ranking_player|
      user_player = current_user.user_players.find_by(player_id: pro_ranking_player.player_id)
      unless user_player.present?
        user_player = current_user.user_players.create!(player_id: pro_ranking_player.player_id)
      end

      new_user_ranking_player = @new_user_ranking_set.user_ranking_players.create(
        user_player: user_player,
        ovr_rank: ovr_rank_count,
        elo_score: (elo_start_point - pro_ranking_player.ovr_rank)
      )
      ovr_rank_count += 1
      next if new_user_ranking_player

      source_ranking_set.destroy_all
      source_ranking_set.errors.add(:pro_ranking_players, 'failed to save properly')
      return false
    end

    true
  end

  def nfbc_ranking_set
    ProRankingSet.find('nfbc-february-adp')
  end

  def filter_params
    params.permit(:position)
  end
end
