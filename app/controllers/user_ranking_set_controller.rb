class UserRankingSetController < ApplicationController

  def show
    @user_ranking_set = UserRankingSet.find(params[:id])
  end

  def create
    new_user_ranking_set = UserRankingSet.create(user_ranking_set_params)
    if new_user_ranking_set
      redirect_to new_user_ranking_set
    else
      redirect_to root_path
    end
  end

  private

  def user_ranking_set_params
    params.require(:user_ranking_set).permit(:ranking_name)
  end
end
