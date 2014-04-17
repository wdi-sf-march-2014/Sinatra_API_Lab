require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

# /css/style.css

get '/' do
	"<link href='/css/style.css' rel='stylesheet'>
	<h1>find a movie, any movie</h1>
	<body>
	<form action='/results'>search by title: <input type='text' name='movie'><input type='submit' value='submit'></form>
	</body>"
end

get '/results' do
	movie = params[:movie]

	if params.keys.length == 0
		return "Please go back and search for a movie."

	else
		response = Typhoeus.get("www.omdbapi.com", :params => {:s => movie })
		parsed_response = JSON.parse(response.body)
		all_titles = parsed_response['Search']
		all_titles_sorted = all_titles.sort_by { |hash| hash['Year'] }

		html_paragraph = ""

		all_titles_sorted.each do |result|
			title = result['Title'].to_s
			year = result['Year'].to_s
			imdbID = result['imdbID']
			html_paragraph += "<br><a href=poster/#{imdbID}> #{title} - #{year}</a><br>"
		end

		"<link href='/css/style.css' rel='stylesheet'>
		<h1>which movie?</h1>
		<body>
		#{html_paragraph}
		</body>"
	end
end

get '/poster/:imdbID' do
	imdbID = params[:imdbID]

	details = Typhoeus.get("www.omdbapi.com", :params => {:i => params[:imdbID] })
	details_parsed = JSON.parse(details.body)
	poster = details_parsed['Poster']

	"<link href='../css/style.css' rel='stylesheet'>
	<h1>here you go. enjoy your eye candy.</h1>
	<img src=#{poster} />"

end
