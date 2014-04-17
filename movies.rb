require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
'<body>
  <div>
  <h1> Welcome to IMDB API MOVIE searcher! Please pick a movie! </h1>
  
<form action="/results" method="get" />
<input type="text" name="movie" class="button" placeholder="E.g. Glitter, Crossroads, attack of the killer tomatoes" />

<button class="sub"> Submit</button> 
<div>
</body>
<style>

sub {
	color: Red;
}





</style>'

end



get '/results' do
  

  res = Typhoeus.get("http://www.omdbapi.com/", :params => { :s => params["movie"] }) 
  json = JSON.parse(res.body) 
  json.inspect
  str = ""
  
  
  json["Search"].each do |movie|
    str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
  end
  str

end

get '/poster/:imdbID' do
  res = Typhoeus.get("http://www.omdbapi.com/", :params => { :i => params["imdbID"] })
  pic = JSON.parse(res.body) 
  "<img src = #{pic["Poster"]} />"

end

  # "#{params[:search]}"
  # "#{response}"
  # "Hello World!"
  # JSON.parse(response.body)
  # puts response.body

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

# <html>
# 	<head>
# 	<h3> "Search for your favorite movies" </h3>
# 	</head>
# # </html>

# response = Typhoeus.get("httpy://www.omdbapi.com/", :params => {:s => "Cars"})
# response2 =  Typhoeus.get("http://www.omdbapi.com/", :params => {:i => 'tt0317219'})