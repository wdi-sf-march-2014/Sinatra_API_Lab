require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do

#anything inside the form will be used as search parameters
#get --> results - this will be in the browser url
#movie the parameter being extracted


html_str = 
<<-eos


	<html>
	<head>
	<h1 style="font-family:Verdana; text-align:center; color:#4B0082">Super Awesome Movie Search!</h1>
	</head>
	<body style="background:#DCDCDC; text-align:center; font-size:20px; color:#006400; font-family:Verdana">
	Search for your favorite movies with:
	<br>Movie Title ~or~ IMDb ID number</br>
	<br>
	<form method="get" action="/results">
	<input type="text" name="movie">
	<input type="submit">
	<p><a href="http://imgur.com/rso1hn6"><img src="http://i.imgur.com/rso1hn6l.jpg" title="Hosted by imgur.com"/></a></p>
	</form>
	</br>
	</body>
	</html>

eos
end

#assigning the search parameter movie to results

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


# get '/?movie=' do
# end


			# "Hello, #{params[:name]} #{params[:last_name]} you are #{params[:age]} and #{params[:height]}"
			# params.inspect
		

# get '/results' do
# end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

# response = Typhoeus.get("http://www.omdbapi.com", :params => {:s => "MovieName", :i => "tt2724064" })


#collect user input from form, push to params
#use get method to call omdb api database
#result will be returned in json
#parse results to show up on /result?movie=<moviename>

