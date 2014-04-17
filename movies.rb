require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
html_str =

<<-eos 
<html>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<h1>ODB Movie Search</h1><p></p><body>Enter a movie title or IMDB ID number here: </body>
<form method="get" action="/results">
<input type="text" name="movie">
<input type="submit">
</form>
<img src="http://www.dustygroove.com/images/products/o/oldirtybast_returntot_101b.jpg"</>
</html>
eos

end

get '/results' do

	search = params[:movie]
	if search == "" || search == nil
		return "Movie not found"
	end

	
	results = Typhoeus.get("http://www.omdbapi.com/?s=#{search}")
	omdb_data = JSON.parse(results.body)
	omdb_data.inspect	

	html_str = 
	<<-eos

	<html>
	<link rel="stylesheet" type="text/css" href="stylesheet.css">
	<head>
	</head>
	<body>
	eos

	omdb_data["Search"].each do |h|
		html_str += "<a href='/poster/#{h["imdbID"]}'><li>#{h["Title"]} - #{h["Year"]}</li></a><br></br>"
	end

	html_str += "</body></html>"
end

get '/poster/:imdbID' do
	search = params[:imdbID]
	html_str = "<html><body>"
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
	omdb_data = JSON.parse(results.body)
	html_str += "<img src='#{omdb_data["Poster"]}' />"
	html_str += "</body></html>"
	return html_str
end









