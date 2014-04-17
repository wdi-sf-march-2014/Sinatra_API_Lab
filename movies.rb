require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
#require 'typhoeus'
require 'json'
require 'httparty'

get '/' do <<EOS
      <!DOCTYPE html>
      <html>
      <head>
      <title>shaker</title>
      </head>
      <body>
        </h1> find your movie </h1>
       <form action="/results" method="get"/>
       <input name ="movie" type="text"><br>
       <button>search</button>
       </form>
       </body>
       </html>
EOS
  
         
       end

get '/results' do
#p  params
   # resp = HTTParty.get("http://www.yahoo.com")
     resp = HTTParty.get("http://www.omdbapi.com?s=#{params[:movie]}") #, :y => params{"year"} we can add year parameter
      odo = JSON.parse(resp.body)
      odo["Search"].inspect
    
  html_str = 
   <<-eos

    <html>
    <head>
    </head>
    <body>
 eos

    odo["Search"].each do |h|
    html_str += "<a href='/poster/#{h["imdbID"]}'>#{h["Title"]} - #{h["Year"]}</a><br></br>"
  end

 html_str += "</body></html>"
  


end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
get '/poster/:imdb_id' do
  imdb_id = params[:imdb_id] 
  html_str = "<html><body>"
  resp = HTTParty.get("http://www.omdbapi.com?i=#{imdb_id}") 
  imdb_id = JSON.parse(resp.body)
  html_str += "<img src='#{imdb_id["Poster"]}' />" 
  html_str += "</body></html>"
  return html_str
end




#def getMoviesTitles_and_IMDB_IDs(str)
#	moviesTitles_and_IMDB_IDs = {}
#	movies = JSON.parse(Typhoeus.get("http://www.omdbapi.com/?s=" + #str).body)
	#p movies

#	movies["Search"].each do |movie| 
	#	moviesTitles_and_IMDB_IDs[movie["Title"]] = movie["imdbID"]
#	end
#	p moviesTitles_and_IMDB_IDs
#end






