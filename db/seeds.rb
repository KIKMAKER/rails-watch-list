# puts "Cleaning database..."
# # Movie.destroy_all

# # puts "Creating movies..."

# # 5.times do
# #   Restaurant.create(
# #     title: Faker::Cosmere.knight_radiant,
# #     overview: Faker::Address.street_address,
# #     phone_number: Faker::PhoneNumber.phone_number,
# #     category: %w[chinese italian japanese french belgian].sample
# #   )
# # end

# # puts "#{Restaurant.count} restaurants created"

# wonder_woman = Movie.create(
#   title: 'Wonder Woman 1984',
#   overview: 'Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s',
#   poster_url: 'https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
#   rating: 6.9
# )
# shawshank = Movie.create(
#   title: 'The Shawshank Redemption',
#   overview: 'Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison',
#   poster_url: 'https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
#   rating: 8.7
# )
# titanic = Movie.create(
#   title: 'Titanic',
#   overview: '101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.',
#   poster_url: 'https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg',
#   rating: 7.9
# )
# oceans = Movie.create(
#   title: "Ocean's Eight",
#   overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.",
#   poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg",
#   rating: 7.0
# )

# drama = List.create(name: 'Drama')
# action = List.create(name: 'Action')

# 40.times do
#   Bookmark.create(
#     comment: 'Want to watch these movies',
#     movie: Movie.all.sample,
#     list: List.all.sample)
# end

# # Bookmark.create(comment: 'Want to watch these movies', movie: shawshank, list: drama)



require 'json'
require 'open-uri'

puts 'Clearing DB'
Bookmark.destroy_all
Movie.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated'
data_serialized = URI.open(url).read
data = JSON.parse(data_serialized)

relevant_infos = data['results']

relevant_infos.each do |info|
  poster_url = "https://image.tmdb.org/t/p/original/#{info['poster_path']}"
  file = URI.open(poster_url)
  movie = Movie.new(
    title: info['original_title'],
    overview: info['overview'],
    poster_url: poster_url,
    rating: info['vote_average']
  )
  movie.photo.attach(
    io: file,
    filename: "#{info['original_title'].gsub(' ', '-')}.png",
    content_type: 'image/png'
  )
  movie.save
end

puts 'Finished!'
puts "Made #{Movie.count} movies"
