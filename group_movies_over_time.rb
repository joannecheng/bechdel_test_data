require 'csv'
require 'json'

year_groups = [
  1970...1975,
  1975...1980,
  1980...1985,
  1985...1990,
  1990...1995,
  1995...2000,
  2000...2005,
  2005...2010,
  2010..2014
]
movies = CSV.read('movies.csv', headers: true)

counts_by_group = year_groups.map do |year_group|
  movies_in_year = movies.select { |c| year_group.to_a.include? c['year'].to_i }

  grouped = movies_in_year.group_by { |movie| movie['bechdel_result_id'] }
  grouped.sort.map do |key, value|
    {
      bechdel_result: key,
      percent: (value.count*1.0) / movies_in_year.count * 100,
      years: "#{year_group.first}-#{year_group.last}"
    }
  end
end

open('bechdel_over_time.json', 'w').write counts_by_group.to_json
