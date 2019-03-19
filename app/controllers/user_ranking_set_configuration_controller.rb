class UserRankingSetConfigurationController < UserRankingSetsLayoutController
  before_action :set_user_ranking_set

  def show

  end

  def edit

  end

  def update
    @user_ranking_set.assign_attributes(user_ranking_set_params)

    if @user_ranking_set.save
      render :show
    else
      render :edit
    end
  end

  private

  def user_ranking_set_params
    params.require(:user_ranking_set).permit(:elo_k_value, :elo_spread, :elo_seed, :elo_init_strategy, :elo_score_strategy, :show_adp_strategy, :ranking_name)
  end

  def set_user_ranking_set
    @user_ranking_set = current_user.user_ranking_sets.find(params[:user_ranking_set_id])
  end
end
