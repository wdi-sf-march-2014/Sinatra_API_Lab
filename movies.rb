require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
html_str = 
	#search and submit
	


	"<html>

	<body>
	<Header>Please Enter A Movie Title</Header>
	
	<form method=get action='/results'>
	<input type='text' name='movie'>
	<input type='submit'>
	</form>
	</body>
	</html>"

end

get '/results' do
	


	#Gets JSON information and display in results page.
search = params[:movie]

if search == "" || search == nil
	return "You broke it"
end	

results = Typhoeus.get("www.omdbapi.com/?s=#{search}")
omdb_data = JSON.parse(results.body)

omdb_data.inspect
html_str = 
<<-eos
<html>
<head>
</head>
<body>
eos
	omdb_data["Search"].each do |h|
		 html_str += html_str += "<a href='/poster/#{h["imdbID"]}'>< #{h["Title"]} - #{h["Year"]}}><br></br>a>"
	end
	html_str += "</body></html>"
end

get '/poster/:imdbID' do

	imdb_id = params[:imdbID]
	new_results = Typhoeus.get("www.omdbapi.com/?i=#{imdb_id}")
	imdb_id= JSON.parse(new_results.body)
	imdb_id.inspect

#imdb_id["Poster"] do |k,v|
#html_str += <a href="v">Poster!</a>

html_str = 
<<-eos
<html>
<head>
</head>
<body>
eos
html_str += "<img src='#{imdb_id["Poster"]}'/>"
end

#get '/poster:imdbID' do
	#imdb_id = params[:imdbID]
# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
#end
