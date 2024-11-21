require 'open-uri'
require 'json'

puts "Cleaning database..."
Movie.destroy_all
puts "Database cleaned."

puts "Fetching movies from API..."
url = 'https://tmdb.lewagon.com/movie/top_rated'
response = URI.open(url).read
movies = JSON.parse(response)['results']

movies.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  puts "Movie created!"
end

puts "Movies successfully created!"
