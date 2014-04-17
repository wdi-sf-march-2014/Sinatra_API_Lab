require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


get '/' do

	'<h1>Welcome to the movie searching database app!</h1>
	<div class="search-form">
	<h1 class="gravitas">Find a Movie!</h1>
	<form accept-charset="UTF-8" action="/result" method="get">
		<input id="movie" name="movie" type="text" placeholder="Search any movie" />
		<input name="commit" type="submit" value="Search" class="btn-sm btn-color"/> 
	</form>
	</div>'

end

 get '/result' do
search_str = params[:movie]
response = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_str})

omdbdata = JSON.parse(response.body)
v = ""
omdbdata["Search"].each do |h|

v += "<a href='/poster/#{h["imdbID"]}'> #{h["Title"]}  #{h["Year"]}</a><br />"
end
return v
end

get '/poster/:imdbID' do
imdb_ID = params[:imdbID]
image = Typhoeus.get("http://www.omdbapi.com/", :params => {:i => imdb_ID})
imagedata = JSON.parse(image.body)
imagedata

  "<img src=#{imagedata['Poster']} />"
end



# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

