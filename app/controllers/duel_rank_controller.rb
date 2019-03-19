class DuelRankController < UserRankingSetsLayoutController
  before_action :set_position_filter, except: %i[reset_elo]
  before_action :set_pagination
  before_action :set_user_ranking_set, except: %i[new create]
  before_action :set_user_ranking_players, only: %i[index show edit update]

  def index

  end

  def show
    if @position_filter == :all
      @user_ranking_players_in_ranking_order = @user_ranking_set.user_ranking_players.order(ovr_rank: :asc).map(&:id)
    else
      @user_ranking_players_in_ranking_order = @user_ranking_set.user_ranking_players
                                                   .where('players.positions & ? > 0', Player.bitmask_for_positions(@position_filter))
                                                   .includes(user_player: [player: [:mlb_team] ]).references(user_player: :player)
                                                   .order(ovr_rank: :asc).map(&:id)
    end
  end

  def edit
    left_offset = rand(@per_page)
    right_offset = rand(@per_page)
    right_offset -= 1 if left_offset == right_offset && right_offset > 0
    @left_choice_user_ranking_player = @user_ranking_players[left_offset]
    @right_choice_user_ranking_player = @user_ranking_players[right_offset]
  end

  def update
    winning_choice = @user_ranking_set.user_ranking_players.find(params[:winning_choice])
    losing_choice = @user_ranking_set.user_ranking_players.find(params[:losing_choice])

    if @user_ranking_set.elo_scoring?
      EloRating::k_factor = @user_ranking_set.elo_k_value
      match = EloRating::Match.new
      match.add_player(rating: winning_choice.elo_score, winner: true)
      match.add_player(rating: losing_choice.elo_score)
      results = match.updated_ratings
      winning_choice.update_column(:elo_score, results[0])
      losing_choice.update_column(:elo_score, results[1])
    elsif @user_ranking_set.swap_scoring?
      if winning_choice.elo_score < losing_choice.elo_score
        high_elo = losing_choice.elo_score
        low_elo = winning_choice.elo_score
        winning_choice.update_column(:elo_score, high_elo)
        losing_choice.update_column(:elo_score, low_elo)
      end
    end

    left_offset = rand(@per_page)
    right_offset = rand(@per_page)
    right_offset -= 1 if left_offset == right_offset && right_offset > 0
    @left_choice_user_ranking_player = @user_ranking_players[left_offset]
    @right_choice_user_ranking_player = @user_ranking_players[right_offset]
    render :edit
  end

  def reset_elo
    @user_ranking_set.reset_elo_scores
    redirect_to user_ranking_set_duel_rank_path(@user_ranking_set, :catcher)
  end

  private

  def set_user_ranking_set
    @user_ranking_set = current_user.user_ranking_sets.find(params[:user_ranking_set_id])
  end

  def set_user_ranking_players
    if @position_filter == :all
      @user_ranking_players = @user_ranking_set.user_ranking_players.paginate(:page => @page, :per_page => @per_page).includes(user_player: [player: [:mlb_team] ]).references(user_player: :player).order(elo_score: :desc)
    else
      @user_ranking_players = @user_ranking_set.user_ranking_players.paginate(:page => @page, :per_page => @per_page)
                                  .where('players.positions & ? > 0', Player.bitmask_for_positions(@position_filter))
                                  .includes(user_player:
                                                 [player: [:mlb_team]]).references(user_player: :player).order(elo_score: :desc)
    end
  end

  def filter_params
    params.permit(:position)
  end

  def set_position_filter
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

  def set_pagination
    @per_page = params[:per_page]&.to_i
    @per_page = [10, 20, 30, 50, 100].include?(@per_page) ? @per_page : (@position_filter == :all ? 50 : 30)

    @page = params[:page]&.to_i || 1
    @page = @page > 0 ? @page : 1

    @offset = (@page - 1) * @per_page
  end
end
