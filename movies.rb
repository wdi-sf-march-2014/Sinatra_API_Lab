require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require_relative'results'



get '/' do <<EOS
  <body>
  <div>
  <h1> Welcome to IMDB Please pick a movie, </h1>
  
<form action="/results" method="get" />
<input type="text" name="movie" class="button" placeholder="E.g. Glitter, Crossroads, attack of the killer tomatoes" />

<button class="sub"> Submit</button> 
<div>
</body>
<style>

  h1 {
    color: black;
    font-family: Londrina-Outline;

  }

  body {
    background-image: url("http://www.hollywoodreporter.com/sites/default/files/2011/12/imdb_a.jpg");
  background-size: cover;
    background-repeat: round;
    
  }
.button {
  background-color: rgb(0, 0, 0, 0.5 );
  padding: 15px 100px;
  box-shadow: 1px 1px 20px 1px;
}
  .sub {
    padding: 14px 77px;
    box-shadow: 1px 1px 20px 1px;
    background-color: rgb(74, 121, 122);
    border-color: rgb(74, 121, 122);
    input: white;: white;
  }
  div {
    
    margin-left: 450px;

  }
  .form {
color: black;
  }
  </style>
EOS
end


  
get '/results' do
  
if params["movie"] == ""
    #return "Pick a movie a-hole.."
    redirect "/"
  end


  res=Typhoeus.get("www.omdbapi.com/", :params => { :s => params["movie"] }) 
  json = JSON.parse(res.body) 
  str = ""
   
  
  json["Search"].each do |movie|
    str += "<div class='form'><br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br></div>"
  end
  str

end

get '/poster/:imdbID' do
  res=Typhoeus.get("www.omdbapi.com/", :params => { :i => params["imdbID"] })
  pic = JSON.parse(res.body) 
  "<img src = #{pic["Poster"]} />"

end

