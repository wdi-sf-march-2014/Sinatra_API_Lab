require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	"<form action='/results'>Search Movie Title: <input type='text' name='movie'><input type='submit' value='Submit'></form>"
end

get '/results' do
	if params.keys.length == 0
		return "Please go back and search for a movie."
	end

	movie = params[:movie]

	response = Typhoeus.get("www.omdbapi.com", :params => {:s => movie })

	parsed_response = JSON.parse(response.body)

	all_titles = parsed_response['Search']

	html_paragraph = ""

	all_titles.each do |result|
		title = result['Title'].to_s
		year = result['Year'].to_s
		imdbID = result['imdbID']
		html_paragraph += "<br><a href=poster/#{imdbID}> #{title} - #{year}</a><br>"
	end

	"#{html_paragraph}"

end

# get '/poster' do

# 	id = params[:imdbID]



# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
