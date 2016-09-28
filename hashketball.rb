require 'pry'

def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black","White"],
      players: {
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      }
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise","Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12
        }
      }
    }
  }
end

def players(team = nil)
  game_hash.each_with_object({}) do |(home_or_away,team_attributes),players_hash|
    players_hash.merge!(team_attributes[:players]) if team_attributes[:team_name] == team || !team
  end
end

def num_points_scored(name)
  players[name][:points]
end

def shoe_size(name)
  players[name][:shoe]
end

def team_colors(team)
  game_hash.each {|home_or_away,team_attributes| return team_attributes[:colors] if team_attributes[:team_name] == team}
end

def team_names()
  game_hash.each_with_object([]) {|(home_or_away,team_attributes), team_names| team_names << team_attributes[:team_name]}
end

def player_numbers(team)
  players(team).each_with_object([]) {|(name, stats), player_numbers| player_numbers << stats[:number]}
end

def player_stats(name)
  players[name]
end

def big_shoe_rebounds
  largest_shoe = 0
  rebounds = 0

  game_hash.each do |home_or_away,team_attributes|
    team_attributes[:players].values.each do |stats|
      if stats[:shoe] > largest_shoe
        largest_shoe = stats[:shoe]
        rebounds = stats[:rebounds]
      end
    end
  end

  rebounds
end

def most_points_scored
  highest_points = 0
  highest_points_player = nil

  game_hash.each do |home_or_away,team_attributes|
    team_attributes[:players].each do |name, stats|
      if stats[:points] > highest_points
        highest_points = stats[:points]
        highest_points_player = name
      end
    end
  end

  highest_points_player
end

def winning_team
  home_team = game_hash[:home][:team_name]
  home_points = 0
  players(home_team).each do |name, stats|
    home_points += stats[:points]
  end

  away_team = game_hash[:away][:team_name]
  away_points = 0
  players(away_team).each do |name, stats|
    away_points += stats[:points]
  end

  if home_points > away_points
    home_team
  elsif home_points < away_points
    away_team
  else
    "Draw"
  end
end

def player_with_longest_name
  longest_name = ""

  game_hash.each do |home_or_away,team_attributes|
    team_attributes[:players].each do |name, stats|
      if name.length > longest_name.length
        longest_name = name
      end
    end
  end

  longest_name
end

def long_name_steals_a_ton?
  most_steals = 0

  game_hash.each do |home_or_away,team_attributes|
    team_attributes[:players].each do |name, stats|
      if stats[:steals] > most_steals
        most_steals = stats[:steals]
      end
    end
  end

  player_stats(player_with_longest_name)[:steals] == most_steals
end

binding.pry