# Phase-3-project
## Flatiron School phase 3 project
This is the backend of a multi-room, multi-user chatroom app.  
It uses Sinatra and Active Record on the backend and React on the frontend.

<br>

The app works with the following steps:
* Upon arriving to the site, a user would need to Log in, or Sign up if it is their first time visiting the site.  The app saves the log in info to the server. 
* Once logged in, the user is presented with a list of the existing chat rooms, with the option of creating a new room.  If a new room is created, it will be added to the list.
* Clicking a room moves the user to the room, where the messages from all the users are presented in the style of a smartphone messaging app, with the user's own messages shown on the right side, and other messages on the left with their respective authors.
* Messages can be deleted by turning on the delete mode, and then selecting the individual message to delete.
* Multiple users can be logged in and their messages are delivered at close to real time.

<br>
Currently the app uses a reoccuring timed fetch request to update the incoming messages from the server.  In the future I may update this to use websockets or another technology in order to have truly live message delivery, but that method is beyond the scope of the learning intentions of the project.

<br>

To use the app, clone the repository to your local machine.  Also visit  
https://github.com/readlang/phase-3-project-frontend for the repository of the React front end.  

Thank you for your interest in this app.