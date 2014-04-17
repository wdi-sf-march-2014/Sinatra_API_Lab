require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
html_str = 
<<-eos
	<html>
	<header>
	<h1 style="text-align:center;color:#2A2C31">Search the OMDB Database!</h1>
	</header>
	<body style="background:#71D2BD; text-align:center; color:#2A2C31">
	Enter the movie name or the IMDB id:
	<br>
	<form method="get" action="/results">
	<input type="text" name="movie">
	<input type="submit">
	</form>
	<br>
	<br>
	<img src="http://sandwichbuffet.co.uk/wp-content/uploads/2014/01/movie-reel-clip-art-21.jpg" style="text-align:center, height:400px; width:400px">
	</body>
	</html>
eos
end

get '/results' do
search = params[:movie].gsub(" ", "+")
results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
ombd_data = JSON.parse(results.body)
html_str = 
	<<-eos
		<html>
		<head>
		</head>
		<body>
	eos

if ombd_data["Search"] == nil
	html_str += "<h1>Sorry, we could not find that title. Try again.</h1>"
else
	ombd_data["Search"].each do |h|
	html_str += "<a href='/poster/#{h["imdbID"]}'><li>#{h["Title"]} - #{h["Year"]}<br></br></li></a>"
	end
end
html_str += "</body></html>"
end

get '/poster/:imdbID' do
	search = params[:imbdID]
	html_str = "<html><body>"
	results = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbID]}")
  ombd_data = JSON.parse(results.body)
  html_str += "<img src='#{ombd_data["Poster"]}'/>"
  html_str += "</body></html>"
  return html_str
end
