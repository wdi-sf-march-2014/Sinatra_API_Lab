require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do 
  html = "<html>"
  html += '<p>Search for a movie</p>'
  html += '<form method="get" action="/results">'
  html += '<input type="text" name="movie"/><input type="submit" /></form>'
  html += "</html>"
  return html
end

#if the movie isn't there, then say sorry
get '/results' do
  html = "<html>\n"
  if params[:movie] == ""
    html += "Not found. pick another" 
  else 
    movie_name = params[:movie]
    response = Typhoeus.get("http://www.omdbapi.com/?s=#{movie_name}")
    result = JSON.parse(response.body)
    if result.has_key?("Error")
      html += "Not found. Pick an actual movie, dumbass."
    else !result.nil?
      result["Search"].each { |movie| html = html + "<a href='/poster/#{movie["imdbID"]}'><li>" + movie["Title"].to_s + " - " + movie["Year"].to_s + "</li></a>\n" }
    end
  end
  html += "</html>"
  return html
end

get '/poster/:imdbid' do
  html = "<html>\n"
  response = Typhoeus.get("http://www.omdbapi.com/?i=#{params[:imdbid]}")
  result = JSON.parse(response.body)
  html += "<img src='#{result["Poster"]}'/>"
  html += "<html>\n"
  html += "</html>"
  return html
end

# response = Typhoeus.get("http://www.omdbapi.com", :params => {:s => "Batman", :y => 2006})

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'


# <li><a href="h" list-style="none"></a><li>


