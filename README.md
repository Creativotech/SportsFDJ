# SportsFDJ

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Clean Swift VIP](#clean-swift-vip)
* [ViewController](#viewcontroller)
* [Models](#models)
* [Router](#router)
* [Worker](#worker)
* [Interactor](#interactor)
* [Presenter](#presenter)
* [Notes](#notes)

# General info

This project is demo sample for consuming the API https://www.thesportsdb.com/api.php
Excercice for the FDJ

# Technologies

Project is created with:
* Swift 
* Clean Swift VIP Architecture (template: https://drive.google.com/file/d/1BIj7j_4UZikdwVtIkoBZEgeijrWTNMP4/view)
* KingFisher  (https://github.com/onevcat/Kingfisher) for downloading and caching images

# Clean Swift VIP

I have used the Clean Swift (a.k.a VIP) architecture applied to iOS. I think its the most advanced architecture right now in terms of clean code / proper legacy / fast understanding/debugging/editing

I tried to stick to this layers as i was developing the demo :

* View Controller
* Models
* Router
* Worker
* Interactor
* Presenter

# View Controller

View Controller starts and ends the VIP cycle
This class has a one-sided interaction with the Presenter
sends data to the Interactor
View Controller gets responses from the Presenter but can’t transfer anything to it

In the demo, the viewcontroller receive the instructions from the presenter to :
- Show the leagues
- Show the teams
- Show an api call error

The viewcontroller use the interactor to trigger the fetch for the data (leagues for autocompletion, the teams when a league is selected)

# Models

 Models is a class containing such structures as Request, Response, and ViewModel:

* Request <br/>
A request model contains parameters sent to the API request (search text to fetch the leagues, fetching the teams of the selected leagues)
* Response <br/>
This type of model receives the response from the API and stores the appropriate data (leagues, teams)
* ViewModel <br/>
This model encapsulates responses sent to the Presenter

# Router
The Router deals with transitions by passing data between view controllers

This demo only required one router to control the flow between the search screen and the team details screen (consuming also the protocol data passing)

# Worker
The Worker handles all the API calls (fetching the leagues, fetching the teams, parsing/decoding the data)

# Interactor 
The Interactor is an intermediary between the Worker and Presenter
First, it communicates with the ViewController
which passes all the query parameters required for the Worker (getting the leagues first than fetching the teams through a selected proper name league)
Before sending data to the Worker
the Interactor checks this data
If everything is good, the Worker returns the response 
and the Interactor sends a response to the Presenter

# Presenter

The Presenter is responsible for presentation/display logic.
It decides how data will be presented to the user. 
The Presenter organizes the response sent by the Interactor into view models suitable for display (formatting them).
Next, the Presenter passes those view models back to the View Controller to display to the user.

# Notes
No need to consume the api "searchteams", it will cost more processing with no gain. All the data we get from that api, is already loaded from the api "search_all_team".
The teamdetails layer only need the UI part to consume the model team.

# Unit tests
Some unit tests are available :
	Test the Interactor
	Test the Presenter
	Test the ViewController
More tests can be done
