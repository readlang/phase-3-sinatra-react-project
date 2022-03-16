class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/login/:user/:pass" do
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
    #first need to check if username is already registered
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
    #post create message
  end

 

  #delete message

  

end
