class UserPlayersController < ApplicationController
  before_action :set_user_players, only: :index
  before_action :set_redirect_to
  before_action :set_user_player, except: %i[index autocomplete]

  respond_to :html, :json

  def index; end

  def show; end

  def edit
    respond_modal_with @user_player
  end

  def update
    @user_player.assign_attributes(user_player_params)
    if @user_player.save
      redirect_to (@redirect_to.present? ? @redirect_to : user_player_path(@user_player))
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user_player.errors.full_messages, status: :unprocessable_entity }
        format.js   { render json: @user_player.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def autocomplete
    matching_user_players = search(params[:term])
    user_player_options = matching_user_players.map { |user_player| autocomplete_option_for_user_player(user_player) }
    render json: user_player_options
  end

  def autocomplete_option_for_user_player(user_player)
    {
      id: user_player.id,
      label: user_player.player.display_name,
      value: user_player.player.display_name,
      navigate_to: user_player_path(user_player)
    }
  end

  private

  def set_user_players
    @user_players = current_user.user_players.includes(player: [:mlb_team]).all
  end

  def set_user_player
    @user_player = current_user.user_players.find(params[:id])
  end

  def user_player_params
    params.require(:user_player).permit(UserPlayer.acceptable_params)
  end

  def search(term)
    return [] if term.blank?

    user_players = current_user.user_players.includes(:player)
                               .where('players.autocomplete_search_field ILIKE ?', "%#{term}%")
                               .order('players.full_name').limit(10)

    user_players
  end

  def set_redirect_to
    @redirect_to = params[:redirect_to]
  end
end
