require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	<<-eos
	<form action="/results" method="get">
	<input type='text' name="movie" >
	<button>Submit</button>
	</form>
	eos
end


get '/results' do
	arr = []
	search_string = params[:movie]
	search = Typhoeus.get("http://www.omdbapi.com/", :params => {:s => search_string})
	result = JSON.parse(search.body)
	result["Search"].to_s
	result["Search"].each do |instance|
		arr << "#{instance["Title"]} #{instance["Year"]}"
	end
	arr.join(" ")
end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
# get '/poster/'
# end
