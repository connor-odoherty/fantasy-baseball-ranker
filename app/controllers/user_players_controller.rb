class UserPlayersController < ApplicationController
  before_action :set_user_players, only: :index
  before_action :set_user_player, except: :index

  def index; end

  def show
  end

  def edit
    @user_player.user_player_articles.build if @user_player.user_player_articles.none?
  end

  def update
    @user_player.assign_attributes(user_player_params)
    if @user_player.save
      redirect_to user_players_path(@user_player)
    else
      render 'edit'
    end
  end

  private

  def set_user_players
    @user_players = current_user.user_players.all
  end

  def set_user_player
    @user_player = current_user.user_players.find(params[:id])
  end

  def user_player_params
    params.require(:user_player).permit(UserPlayer.acceptable_admin_params)
  end
end

