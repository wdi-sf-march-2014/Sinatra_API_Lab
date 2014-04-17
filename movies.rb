require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

# s (NEW!)	 string (optional)	 title of a movie to search for
# i	 string (optional)	 a valid IMDb movie id
#get request will be to own server / action = result

get '/' do <<EOS
	  <h1> Movie search knock pants off </h1> 
		<form action="/results" method="get" />
		<input type="text" name="movie" placeholder="E.g. Police Academy" />
		<input type="submit"> 
EOS
	end
			# <input type="text" name="year" value="2006" />

get '/results' do
	res=Typhoeus.get("www.omdbapi.com/", :params => { :s => params["movie"] })  # :y => params["year"]
  json = JSON.parse(res.body) 
  str = ""
  p json.to_s
 	# json["Search"].each do |movie|
 	# 	str += "<br><a href> #{movie["Title"]} - #{movie["Year"]} </a><br>"
 	# end
 	# str

end

get '/poster/[imdb_id]' do
	res=Typhoeus.get("www.omdbapi.com/", :params => { :t => params["movie"] })
end

