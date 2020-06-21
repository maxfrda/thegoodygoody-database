# README
This creates the database by parsing xml files and converting them into Active Record models. 
I created a service object with Nokogirl and SAX to parse the xml files. The object can be used to parse ANY xml file, you just have to create a service object that inherits the xml service object, along with a model and controller for whichever object you want to populate database with. The service object that you create i.e(Artist) just needs to create one method, this is required because we want to be able to customize what we parse the data for, and also so that we can specify which object we will be adding to our database. 


* ...
