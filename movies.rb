require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


get '/' do
	# "{params[:movie]}"
	html_str = 
<<-eos
	<html>
	<body>
	<header>
	<h1>Enter a Movie title here to Search<h1>
	<header>
		<form method="get" action="/results">

		<input type='text' name='movie'>
		<input type='submit'>

		</form>

		<body>
		</html>
eos

end
	



get '/results' do

	search = params[:movie]

	if search == "" || search == nil
		return "This movie does not exist"
	end
	
	results = Typhoeus.get("www.omdbapi.com/?s=#{search}")
	imdb_data = JSON.parse(results.body) #{search}))
	
	imdb_data.inspect

	# if results != do
	# 	"Movie Does not Exist"
	

html_str =
<<-eos

<html>
<head>
</head>
<body>	
eos
	imdb_data["Search"].each do |h| 
		html_str += "<a href='/poster/#{h["imdbID"]}'>< #{h["Title"]} - #{h["Year"]}}><br></br>a>"
	end

	html_str += "</body></html>"

	

end



get '/poster/:imdbID' do
	imdb_id = params[:imdbID]
	new_results = Typhoeus.get("www.omdbapi.com/?i=#{imdb_id}")
	imdb_id= JSON.parse(new_results.body)
	imdb_id.inspect

	html_str = 
<<-eos
<html>
<head>
</head>
<body>
eos
html_str += "<img src='#{imdb_id["Poster"]}'/>"

end
# should look like this example '/poster/tt2724064'

#imdbid[Poster].value