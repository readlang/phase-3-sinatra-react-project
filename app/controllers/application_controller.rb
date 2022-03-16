class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/login/:user/:pass" do
    #this could be a post instead of a get
    user = params[:user]
    pass = params[:pass]
    if User.find_by(username: user) == nil
      {message: "Username not found", username: user }.to_json
    else
      if pass == User.find_by(username: user).password
        {message: "Authorized", username: user, id: User.find_by(username: user).id }.to_json
      else
        {message: "Not authorized", username: user}.to_json
      end 
    end    
  end

  get "/rooms" do
    rooms = Room.all
    rooms.to_json
  end

  get "/room/:id/messages" do
    #check if room is locked to new users?
    room_id = params[:id].to_i
    messages = Message.where(room_id: room_id)
    messages.to_json
  end
  
  post "/signup" do
    if User.find_by(username: params[:username]) != nil
      {message: "Username is already taken", username: params[:username]}.to_json
    else
      new_user = User.create(
        username: params[:username],
        password: params[:password]
      )
      new_user.to_json
    end

  end

  post "/create_room" do
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

  post "/create_message" do
    new_message = Message.create(
      user_id: params[:user_id],
      room_id: params[:room_id],
      message_text: params[:message_text]
    )
    new_message.to_json
  end
 
  delete "/delete_message/:id" do
    message = Message.find(params[:id])
    message.destroy
    message.to_json
  end

  # frontend will need some way to check for a new message from the other members of chat room
  # or a way to "push" the message from the backend

end
