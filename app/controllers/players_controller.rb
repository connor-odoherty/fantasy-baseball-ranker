class PlayersController < ApplicationController
  before_action :set_players

  def index

  end

  private

  def set_players
    @players = Player.all
  end
end
