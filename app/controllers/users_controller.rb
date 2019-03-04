class UsersController < ApplicationController
  skip_before_filter :require_login

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Player.all.find_each { |player| @user.user_players.create!(player: player) }
      log_in @user
      flash[:success] = 'Welcome to Duel Rank'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
