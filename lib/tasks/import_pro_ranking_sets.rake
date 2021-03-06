# frozen_string_literal: true

task import_nfbc_adp: :environment do
  count = 0
  # set_slug = 'nfbc-feb-adp'
  #
  # adp_ranking_set = ProRankingSet.find()
  # if adp_ranking_set.present?
  #   adp_ranking_set.pro_ranking_players.destroy_all
  #   adp_ranking_set.destroy
  # end

  existing_nfbc_adp = ProRankingSet.find_by(slug: ProRankingSet.current_ranking_slug)
  existing_nfbc_adp.destroy if existing_nfbc_adp.present?
  adp_ranking_set = ProRankingSet.create(
    publication_name: 'NFBC',
    ranking_name: 'March ADP 2020',
    ranker_name: 'Site',
    url: 'https://playnfbc.shgn.com/adp',
    published_at: DateTime.now
  )

  unless adp_ranking_set.save
    pp adp_ranking_set.errors.full_messages
    raise 'Pro ranking set failed to save'
  end

  row_count = 0
  count = 0
  CSV.foreach('nfbc_adp_set_20200223.csv') do |row|
    row_count += 1
    next if row_count == 1

    rank = row[0].to_i
    last_then_first = row[1]
    last_name = last_then_first.split(', ')[0]
    first_name = last_then_first.split(', ')[1]
    full_name = first_name + ' ' + last_name
    adp = row[4].to_f
    min_pick = row[5].to_i
    max_pick = row[6].to_i
    player_match = find_player_match_for_full_name(full_name)
    unless player_match.present?
      p "No match found for #{full_name}"
      next
    end

    next if player_match.full_name == "Will Smith"

    count += 1
    new_player_rank = adp_ranking_set.pro_ranking_players.build(
      player_id: player_match.id,
      # pro_ranking_set_id: adp_ranking_set.id,
      ovr_rank: rank,
      adp: adp,
      min_pick: min_pick,
      max_pick: max_pick
    )
    unless new_player_rank.save
      pp new_player_rank.errors.full_messages
      raise "Pro ranking player #{full_name} failed to save"
    end
  end

  p "#{count} players added to ranks!"
end

def find_player_match_for_full_name(full_name)
  return Player.find_by(full_name: full_name) if Player.find_by(full_name: full_name).present?
  return Player.find_by(mlb_name: full_name) if Player.find_by(mlb_name: full_name).present?
  return Player.find_by(bref_name: full_name) if Player.find_by(bref_name: full_name).present?
  return Player.find_by(cbs_name: full_name) if Player.find_by(cbs_name: full_name).present?
  return Player.find_by(espn_name: full_name) if Player.find_by(espn_name: full_name).present?
  return Player.find_by(fg_name: full_name) if Player.find_by(fg_name: full_name).present?
  return Player.find_by(nfbc_name: full_name) if Player.find_by(nfbc_name: full_name).present?
  return Player.find_by(retro_name: full_name) if Player.find_by(retro_name: full_name).present?
  return Player.find_by(yahoo_name: full_name) if Player.find_by(yahoo_name: full_name).present?
  return Player.find_by(rotowire_name: full_name) if Player.find_by(rotowire_name: full_name).present?
  return Player.find_by(ottoneu_name: full_name) if Player.find_by(ottoneu_name: full_name).present?

  nil
end

task update_players_with_most_recent_adp: :environment do
  Player.all.update_all(adp: nil)
  ProRankingSet.last.pro_ranking_players.find_each do |pro_ranking_player|
    pro_ranking_player.player.update_column(:adp, pro_ranking_player.adp)
  end
end

task import_nfbc_adp_and_update_players_with_most_recent_adp: :environment do
  Rake::Task["import_nfbc_adp"].invoke
  Rake::Task["update_players_with_most_recent_adp"].invoke
end
