# Sinatra and OMDB API Lab
A lab for creating a simple sinatra application that uses the the OMDB api

# Objective

The goal of the lab is to get comfortable with sinatra, api calls and json.  By the end of the lab, you should have an app that uses routes, forms, and an api call that returns json.

# Instructions

Create a movie searching application using the OMDB json api: [http://www.omdbapi.com/](http://www.omdbapi.com/).  For the lab, you will be calling the omdb api using the 's' parameter and the 'i' parameter.

* Phase 1 - Create a simple search, that presents a form to the user to search for movies.  The form should be routed to a page at '/'.  On that page, the user can search for a movie.  The results of the search should be routed to a page at '/results'. The results page should list all of the movies found by the search and the year the movie was made.
	* __IMPORTANT__ pass a parameter to the results page called ```movie```.  This is assumed in the tests, so the tests will not pass without this parameter.
	

* Phase 2 - On the results page, turn each movie and year string into a link.  The link should go to another page called '/poster/[imdb_id]'  On this page the poster of the imdb id given in the url should be displayed

* Phase 3 (Extra) - On the results page, display the movies in sorted order by year.
* Phase 4 (Extra) - Add more rspec tests that tests your sites functionality.

* Phase 5 (Extra) - Add some some styling to the page using CSS.  This requires linking each page to a style sheet and having sinatra return the style sheet as well. 

__Suggestions__:

* Make sure to read over and run the rspec tests.
* Make some very simple pages just to get all the routes working.  Then build up to the movie app.
* Even if you do not write your own tests, try to understand what the tests are doing to test the app.
* Check out the __[sinatra docs](http://www.sinatrarb.com/intro.html)__ if you don't know how to do something in sinatra.


