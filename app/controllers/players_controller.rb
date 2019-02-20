# frozen_string_literal: true

class PlayersController < ApplicationController
  before_action :set_players, only: :index
  before_action :set_player, except: :index

  def index; end

  def show
  end

  def edit
    @player.player_articles.build
  end

  def update
    @player.assign_attributes(player_params)
    if @player.save
      redirect_to players_path(@player)
    else
      render 'edit'
    end
  end

  private

  def set_players
    @players = Player.all
  end

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(Player.acceptable_admin_params)
  end
end
