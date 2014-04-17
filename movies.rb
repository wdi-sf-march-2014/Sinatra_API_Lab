require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	'<h1>My Movie Search</h1>
	<form action="/results" method="get">
	<input type="search" placeholder="Movie title" name="movie">
	<input type="submit" value="search">
	<form>'

	#if "#{:params[:movie]}" == "#{:params[:movie]}"

end

get '/results' do

	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => "#{params[:movie]}"})
	result = JSON.parse(response.body)
	str = "<h1> Movie List</h1>"
  result["Search"].each do |movie|
    str += "<br><a href=/poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
  end
  str
end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

get '/poster/:imdb_id' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => "#{params[:imdb_id]}"})
	result = JSON.parse(response.body)

	
	 "<h1>Poster Page</h1><img src = #{result['Poster']}></img>"
 end

get '/error' do

end

