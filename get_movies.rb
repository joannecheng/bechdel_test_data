require 'pry'
require 'csv'

year_re = /^(\d{4})/
movie_name_and_result_re = /\[(\d)\]\](.*)\[/

lines = open('movie_list.txt').read.split("\n")
current_year = 2014
movies = []

lines.each do |line|
  if !year_re.match(line).nil?
    current_year = year_re.match(line)[1]
  elsif !movie_name_and_result_re.match(line).nil?
    matches = movie_name_and_result_re.match(line)
    movies << [current_year, matches[1], matches[2].strip]
  end
end

CSV.open('movies.csv', 'w') do |csv|
  movies.each do |movie|
    csv << movie
  end
end
