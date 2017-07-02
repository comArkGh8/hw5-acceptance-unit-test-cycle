

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /the director of "(.+)" should be "(.+)"/ do |movie_title, director|
  movie = Movie.find_by(title: movie_title)
  
  visit movie_path(movie)
  expect(/Director:[\s\S]*#{director}/).to match(page.body)
end
  
