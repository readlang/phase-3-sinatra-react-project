require "pry"

# get /rooms - get all rooms
# get /rooms/id - get a specific room

# get /rooms/new - make a new room (frontend route)
# post /rooms    - create a new room (backend route)

# get /rooms/id/edit - edit a specific room (frontend route)
# patch /rooms/id  - edit a specific room (backend route)

# delete /rooms/id - delete a specific room



class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # These are Login actions, which will live in App
  post "/login" do
    username = params[:username]
    password = params[:password]
    if User.find_by(username: username)
      if password == User.find_by(username: username).password
        {message: "Authorized", username: username, id: User.find_by(username: username).id }.to_json
      else
        {message: "Incorrect password", username: username, id: 0 }.to_json
      end 
    else
      {message: "Username not found", username: username, id: 0 }.to_json
    end    
  end

  post "/signup" do
    if User.find_by(username: params[:username])
      {message: "Username is already taken", username: params[:username], id: 0 }.to_json
    else
      new_user = User.create(
        username: params[:username],
        password: params[:password]
      )
      {message: "Authorized", username: new_user[:username], id: new_user[:id] }.to_json
    end
  end


  # These are Room actions, which live in RoomSelect
  #gets all the rooms
  get "/rooms" do
    rooms = Room.all
    rooms.to_json
  end

  #gets a single room containing this id#
  get "/rooms/:id" do
    room_id = params[:id].to_i
    room = Room.find(room_id)
    room.to_json
  end

  post "/rooms" do
    if Room.find_by(room_name: params[:room_name]) != nil
      {message: "Room already exists", room_name: params[:room_name]}.to_json
    else
      new_room = Room.create(
        room_name: params[:room_name],
        room_detail: params[:room_detail]
      )
      new_room.to_json
    end
  end

  # get the users for a particular room (without sharing passwords)
  get "/rooms/:id/users" do
    users = Room.find(params[:id].to_i).users.distinct.select(:id, :username)
    users.to_json
  end


  # These are Message actions, which live in MessageRoom
  #this gets all the messages of a particular room
  get "/rooms/:id/messages" do
    #check if room is locked to new users?
    # how would I send this combined with the Name of the user, rather than the user id?
    room_id = params[:id].to_i
    messages = Room.find(room_id).messages
    messages.to_json
  end
  
  post "/rooms/:id/messages" do
    room_id = params[:id].to_i
    new_message = Message.create(
      user_id: params[:user_id],
      room_id: room_id,
      message_text: params[:message_text]
    )
    new_message.to_json
  end
 
  delete "/rooms/:id/messages/:message_id" do
    message = Message.find(params[:message_id].to_i)
    message.destroy
    message.to_json
  end

end

  # frontend will need some way to check for a new message from the other members of chat room
  # seems like it should just check (get request) every 5 seconds or something
  # or a way to "push" the message from the backend - not sure if this is possible