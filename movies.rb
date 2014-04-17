require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do <<EOS
	  <h1> Movie search knock pants off </h1> 
		<form action="/results" method="get" />
		<input type="text" name="movie" placeholder="E.g. Police Academy" />
		<input type="submit"> 
EOS
end

get '/results' do
	if params.keys.length == 0 or params.keys.length == nil
		return "Please get a clue."
	end

	res=Typhoeus.get("www.omdbapi.com/", :params => { :s => params["movie"] })  # :y => params["year"]
  json = JSON.parse(res.body) 
  str = ""
  # p json.to_s
 	
 	json["Search"].each do |movie|
 		str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
 	end
 	str

end

get '/poster/:imdbID' do
	res=Typhoeus.get("www.omdbapi.com/", :params => { :i => params["imdbID"] })
	pic = JSON.parse(res.body) 
	"<img src = #{pic["Poster"]} />"

end

