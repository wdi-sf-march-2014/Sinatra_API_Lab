require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


def getMovieDetails(str)
	movies = JSON.parse(Typhoeus.get("http://www.omdbapi.com/?s=" + str).body)["Search"]
	# movies = [{"Title"=>"Peter Pan", "Year"=>"1953", "imdbID"=>"tt0046183", "Type"=>"movie"}, {"Title"=>"Peter Pan", "Year"=>"2003", "imdbID"=>"tt0316396", "Type"=>"movie"}, {"Title"=>"The Life and Death of Peter Sellers", "Year"=>"2004", "imdbID"=>"tt0352520", "Type"=>"movie"}, {"Title"=>"Peter's Friends", "Year"=>"1992", "imdbID"=>"tt0105130", "Type"=>"movie"}, {"Title"=>"Peter & the Wolf", "Year"=>"2006", "imdbID"=>"tt0863136", "Type"=>"movie"}, {"Title"=>"Peter and the Wolf", "Year"=>"1946", "imdbID"=>"tt0038836", "Type"=>"movie"}, {"Title"=>"Peter and the Wolf", "Year"=>"1946", "imdbID"=>"tt0038836", "Type"=>"movie"}, {"Title"=>"Peter", "Year"=>"2010", "imdbID"=>"tt1537137", "Type"=>"episode"}, {"Title"=>"Peter Pan", "Year"=>"1960", "imdbID"=>"tt0054176", "Type"=>"movie"}, {"Title"=>"Peter and Vandy", "Year"=>"2009", "imdbID"=>"tt1144551", "Type"=>"movie"}]
	# p movies
end

def displaySearchResults


end


# p getMovieDetails("whatever :)")


get '/' do
	'
	<html>
	<head>
		<title>Movie search</title>
	</head>
	<body>
		<h1>Search for a movie<h1>

		<form action="/results" method="POST">
    		Movie Name: <input type="text" name="name">
		    <input type="submit">
		</form>
	</body>
	</html>
'	
end

get '/results' do
	'
	<a href="/">About Me</a>
	'
end 

 # get '/poster/' do
# 	'
# 	<img src="/">
# 	'
# end 

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

