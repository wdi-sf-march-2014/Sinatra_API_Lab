require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do

  '<h1> Welcome to the Movie Search Page!</h1>
   <p>Please enter your movie below:</p>
   <form action="/results" method="get">
   Movie: <input type="text" name="movie"><br>
   <input type="submit" value="Submit"></form>'

end

get '/results' do

  response = Typhoeus.get("http://www.omdbapi.com/",:params => {:s => "#{params[:movie]}"})
  result = JSON.parse(response.body)
  str = ""
    result["Search"].each do |movie|
    str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"
    end
  str
end

get '/poster/:imdbID' do
  response = Typhoeus.get("http://www.omdbapi.com/",:params => {:i => "#{params["imdbID"]}"})
  result = JSON.parse(response.body)
  "<img src = #{result["Poster"]} />"

end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'

