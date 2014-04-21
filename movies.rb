require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	'<h1>Movie Search</h1>
		<form action="/results" method="get">
		<input type="search" placeholder="Movie Name" name="movie">
		<input type="submit" value="search">
		<form>'
end

get '/results' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => params[:movie]})
	result = JSON.parse(response.body)
	str = "<h1> Movie List</h1>"
  	result["Search"].each do |movie|
    str += "<br><a href=/poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"	
	end
	str
end

get '/poster/:imdb_id' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i =>[:imdb_id]})
	result = JSON.parse(response.body)
	"<h1>Poster!</h1><img src = #{result["Poster"]}</img>"
end
