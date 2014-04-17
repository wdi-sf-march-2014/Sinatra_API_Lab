require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'

get '/' do 
  html = "<html>"
  image = "http://greatdubbedmovies.files.wordpress.com/2014/01/1.jpg"
  html += "<body style='background: url(#{image})'>"
  html += '<p</p>'
  html += '<form style="text-align:center" method="get" action="/results">'
  html += '<input type="text" name="movie" placeholder="Find Movies, TV Shows..." style="width: 300px; height: 35px; font-size:25px; font-family:Helvetica"/><button type="submit" value="Search" style="width:100px; font-family:Helvetica; font-size:20px; color:#08233e; background-color:rgba(255,204,0,1)"/>Search</form>'
  html += "</body>"
  html += "</html>"
  return html
end

get '/results' do
  html = "<html>\n"
  if params[:movie] == ""
    html += "Movie not found." 
  else
    movie_name = params[:movie]
    response = Typhoeus.get("www.omdbapi.com/?s=#{movie_name}")
    result = JSON.parse(response.body)
    if result.has_key?("Error")
      html += "Not found. Pick an actual movie, dumbass."
    else !result.nil?
      result["Search"].each { |movie| html = html + "<a href='/poster/#{movie["imdbID"]}' style='text-decoration:none; font-size: 25px; list-style-type: none'><li>" + movie["Title"].to_s + " - " + movie["Year"].to_s + "</li></a>" }
    end
  end
  html += "</html>"
  return html
end

get '/poster/:imdbid' do
  html = "<html>\n"
  response = Typhoeus.get("www.omdbapi.com/?i=#{params[:imdbid]}")
  result = JSON.parse(response.body)
  html += "<center><img src='#{result["Poster"]}' height='600' width='450'/></center>"
  html += "<html>\n"
  html += "</html>"
  return html
end