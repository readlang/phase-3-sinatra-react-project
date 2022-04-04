require "pry"

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
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

  # creates a new user and logs them in
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

  # gets all the rooms
  get "/rooms" do
    rooms = Room.all
    rooms.to_json
  end

  # gets a single room with this id
  get "/rooms/:id" do
    room = Room.find( params[:id].to_i )
    room.to_json
  end

  # creates a new room
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

  # gets the users for a single room (without sending passwords)
  get "/rooms/:id/users" do
    users = Room.find(params[:id].to_i).users.distinct.select(:id, :username)
    users.to_json
  end

  # gets all the messages for a single room
  get "/rooms/:id/messages" do
    messages = Room.find( params[:id].to_i ).messages
    messages.to_json
  end
  
  # creates a new message in a room
  post "/rooms/:id/messages" do
    new_message = Message.create(
      user_id: params[:user_id],
      room_id: params[:id].to_i ,
      message_text: params[:message_text]
    )
    new_message.to_json
  end
 
  # deletes a single message
  delete "/messages/:id" do
    message = Message.find( params[:id].to_i )
    message.destroy
    message.to_json
  end
end