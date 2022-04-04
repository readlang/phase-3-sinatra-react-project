# pulled out of application_controller.rb

# Experimental - gets all the messages for a single room - with the usernames
get "/rooms/:id/messageswuser" do
    users = Room.find(params[:id].to_i).users.select(:id, :username)
    messages = Room.find( params[:id].to_i ).messages

    array = []
    messages.length.times do |i|
        array.push( 
        { 
            id: messages[i].id,
            user_id: messages[i].user_id,
            room_id: messages[i].room_id,
            message_text: messages[i].message_text,
            created_at: messages[i].created_at,
            updated_at: messages[i].updated_at,
            username: users[i].username
        }
        )
    end

    array.to_json
end

# Experimental - gets all the messages for a single room - with the usernames
get "/rooms/:id/messageswuser2" do
    users = Room.find(params[:id].to_i).users.select(:id, :username)
    messages = Room.find( params[:id].to_i ).messages

    array = []

    messages.length.times do |i| 
        array.push( { 
        **messages[i].attributes,
        username: users[i].username
        } )
    end

    array.to_json
end
