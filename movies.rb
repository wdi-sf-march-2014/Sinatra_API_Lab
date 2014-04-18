require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'



get '/' do
	'<h1> Search for your favorite movies! </h1>
  <form action="/results" method="get">
  <input type="text" input name="movie" placeholder="Movie Title"><br>
  <input type="submit" value="Submit">
	</form>'
end




get '/results' do

response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => params["movie"]})
parsed = JSON.parse(response.body)

str = ""

parsed['Search'].each do |movie|
	#try putting the full link to poster rather than the imdbID
str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
	end
	str
end
# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

get '/poster/:imdbID' do
	response = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => params["imdbID"]})
	posters = JSON.parse(response.body)
	puts posters
	"<img src = #{posters["Poster"]}/>"
end

