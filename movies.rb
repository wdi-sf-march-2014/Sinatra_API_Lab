require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do
	<<-eos
	<h1>ENTER YOUR SEARCH HERE!</h1>
		<form action="/results" method="get">
		<input type="text" name="movie" >
		<button>Submit</button>
	</form>
	eos
end


get '/results' do
	search_string = params[:movie]

	html_doc = "<html><head></head></body>"
	search = Typhoeus.get("www.omdbapi.com/", :params => {:s => search_string})
	result = JSON.parse(search.body)
	result["Search"].each do |instance|
		# puts result["Search"]
		 title = instance["Title"] 
		 year = instance["Year"]
		 id = instance["imdbID"]
		 search = Typhoeus.get("www.omdbapi.com", :params => {:i => id})
		 result2 = JSON.parse(search.body)
		 poster = result2["Poster"]
		 html_doc += "<br><a href='#{poster}''<br>#{title}: #{year}</a>"
	end 
	html_doc += "</body><html>"
end

# get '/poster' do
# 	id = params[:poster]
# 	receive = Typhoeus.get("http://www.omdbapi.com", :params => {:s => id})
# 	parse = JSON.parse(result.body)
# 	parse["Search"]["imdbID"].to_s
# end



# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
# get '/poster/'
# end
