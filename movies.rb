require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
<<-EOS
	<html>
	<head>
		
	</head>
	<body style="font-family: sans-serif">
		<h1>Movie Search</h1>
		<form action="/results" method="get">
			<input type="text" name="movie" placeholder="movie title">
			<input type="submit" value="Search">
		</form>
	</body>
	</html>
EOS
end

get '/results' do
	movie_title = params[:movie]

	response = Typhoeus.get("http://www.omdbapi.com/?s=#{movie_title.gsub(" ", "%20")}")
	@omdb_hash = JSON.parse(response.body)

	html = 
	<<-EOS
		<html>
		<head>
			<title>Search Results</title>
		</head>
		<body style="font-family: sans-serif">
			<h1>Movie Search</h1>
			<form action="/results" method="get">
				<input type="text" name="movie" placeholder="#{}">
				<input type="submit" value="Search">
			</form>
			<h2>Search Results</h2>
	EOS

	@omdb_hash["Search"].each do |h|
		html += 
<<-EOS
		<a href='/poster/#{h["imdbID"]}'>
			<li style="list-style-type: none">#{h["Title"]} - #{h["Year"]}</li>
		</a>
EOS
end

html += "</body></html>"
end

get '/poster/:imdbID' do
	imdbID = params[:imdbID]
	response = Typhoeus.get("http://www.omdbapi.com/?i=#{imdbID}")
	hash = JSON.parse(response.body)

	html = 
<<-EOS
		<html>
		<head>
			<title>Movie Poster</title>
		</head>
		<body style="font-family: sans-serif">
			<h1>Movie Search</h1>
			<form action="/results" method="get">
				<input type="text" name="movie" placeholder="movie title">
				<input type="submit" value="Search">
			</form>
			<img src=#{hash['Poster']} style="border: 3px solid black; padding: 5px"/>
EOS
end

	
