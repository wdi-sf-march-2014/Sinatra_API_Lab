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
<h1 style="text-align:center;color:#4B0082">Super Awesome Movie Search!</h1>
</header>
<body style="background:#DCDCDC; text-align:center; color:#006400">
Search for your favorite movies with:
<br>Movie Title ~or~ IMDb ID number</br>
<br>
<form method="get" action="/results">
<input type="text" name="movie">
<input type="submit">
</form>
</br>
</body>
</html>

eos
end

get '/results' do

search = params[:movie]

results= Typhoeus.get("www.omdbapi.com/?s=#{search}")
ombd_data = JSON.parse(results.body)


html_str = 
<<-eos

<html>
<head>
</head>
<body>
eos

ombd_data["Search"].each do |h|
	html_str += "<a href='/poster/#{h["imdbID"]}'><li>#{h["Title"]} - #{h["Year"]}<br></br></li></a>"
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






# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

