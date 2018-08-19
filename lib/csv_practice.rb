# csv_practice.rb
require 'csv'
require 'awesome_print'
require 'pry'

# Part 1 - CSV Practice
def load_data(filename)
  CSV.read(filename, headers: true).map {|line| line.to_h}
end

# returns [{},{}]
def total_medals_per_country(olympic_data)
  total_medals_country = Hash.new()
  medal_countries = olympic_data.select { |hash| hash["Medal"] != "NA" } # returns hash
  medal_countries.each do |hash|
    if total_medals_country.has_key?(hash["Team"])
      # take the existing value and add one to it and save it again in the same variable
      total_medals_country[hash["Team"]] += 1
    else
      total_medals_country[hash["Team"]] = 1
    end
  end
  total_medals_country.map{|k,v| {:country => k.to_s, :total_medals => v}}
end

def save_medal_totals(filename, medal_totals)
  CSV.open(filename, 'w') do |csv|
    csv << medal_totals
  end
end

# Part 2 - More Enumerable Practice
def all_gold_medal_winners(olympic_data)
  olympic_data.select { |hash| hash["Medal"] == "Gold" } # returns hash
end

def medals_sorted_by_country(metal_totals)
  metal_totals.sort_by { |hash| hash[:country]}
end

# input [{},{}]
def country_with_most_medals(metal_totals)
  sorted = metal_totals.max_by { |country| country[:total_medals] }
end

# input [{a hash with all info},{a hash with all info}]
# return same data, but with height being in inches instead of centimeters
def athlete_height_in_inches(olympic_data)
  olympic_data.map do |hash|
    hash["Height"] = hash["Height"].to_i * 0.4
  end
  return olympic_data
end
