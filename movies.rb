require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	"<form action='/results'>Search Movie Title: <input type='text' name='movie'><input type='submit' value='Submit'></form>"
end

get '/results' do
	movie = params[:movie]

	if params.keys.length == 0
		return "Please go back and search for a movie."
	end
	
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

get '/poster/:imdbID' do
	imdbID = params[:imdbID]

	details = Typhoeus.get("www.omdbapi.com", :params => {:i => params[:imdbID] })
	details_parsed = JSON.parse(details.body)
	poster = details_parsed['Poster']

	"<img src=#{poster} />"

end
