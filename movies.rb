require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

get '/' do
	<<-eos
		<form action="/results" method="get">
			<div>
				Movie name: <input type="text" name="movie">
				<button>Submit</button>
    	</div>
		</form>


eos
end

get '/results' do
	search_string = params[:movie]

	html_doc = "<html><head></head><body>"
 	search = Typhoeus.get("www.omdbapi.com", :params => {:s => search_string})
 	result = JSON.parse(search.body)
 	result["Search"].each do |x| 
 		#puts result["Search"]
 	 	title = x["Title"]
 	 	year = x["Year"]
 	 id = x["imdbID"]
 	 search = Typhoeus.get("www.omdbapi.com", :params => {:i => id})
 	 result2 = JSON.parse(search.body)
 	 poster = result2["Poster"]
 	 	#html_doc += "#{title} - #{year} <br />"
 	 	html_doc += "<br><a href='#{poster}''><br>#{title} #{year}</a>"
 	 	
 	 	# str += "<br><a href=poster/#{movie["imdbID"]}> #{movie["Title"]} - #{movie["Year"]} </a><br>"""
 	 	#{title} - #{year} <br />"
 	 
 	 end
 	html_doc += "</body></html>"
  
end

# TODO: Add another get here for the poster url.  The path for the poster
# should look like this example '/poster/tt2724064'
