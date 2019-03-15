class DuelRankController < UserRankingSetsLayoutController
  before_action :set_position_filer
  before_action :set_user_ranking_set, except: %i[new create]
  before_action :set_user_ranking_players, only: %i[index show edit update]

  def index

  end

  def show

  end

  def edit
    left_offset = rand(@user_ranking_players.count)
    right_offset = rand(@user_ranking_players.count)
    @left_choice_user_ranking_player = @user_ranking_players[left_offset]
    @right_choice_user_ranking_player = @user_ranking_players[right_offset]
  end

  def update
    winning_choice = @user_ranking_set.user_ranking_players.find(params[:winning_choice])
    losing_choice = @user_ranking_set.user_ranking_players.find(params[:losing_choice])


    if winning_choice.elo_score < losing_choice.elo_score
      high_elo = losing_choice.elo_score
      low_elo = winning_choice.elo_score
      winning_choice.update_column(:elo_score, high_elo)
      losing_choice.update_column(:elo_score, low_elo)
    end

    left_offset = rand(@user_ranking_players.count)
    right_offset = rand(@user_ranking_players.count)
    @left_choice_user_ranking_player = @user_ranking_players[left_offset]
    @right_choice_user_ranking_player = @user_ranking_players[right_offset]
    render :edit
  end

  private

  def set_user_ranking_set
    @user_ranking_set = current_user.user_ranking_sets.find(params[:user_ranking_set_id])
  end

  def set_user_ranking_players
    if @position_filter == :all
      @user_ranking_players = @user_ranking_set.user_ranking_players.includes(user_player: [player: [:mlb_team] ]).references(user_player: :player).order(elo_score: :asc)
    else
      @user_ranking_players = @user_ranking_set.user_ranking_players
                                  .where('players.positions & ? > 0', Player.bitmask_for_positions(@position_filter))
                                  .includes(user_player:
                                                 [player: [:mlb_team]]).references(user_player: :player).order(elo_score: :desc).limit(30)
    end
  end

  def filter_params
    params.permit(:position)
  end

  def set_position_filer
    @position_filter = if params[:id].present?
                         params[:id].to_sym
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
end
