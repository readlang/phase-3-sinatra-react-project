puts "🌱 Seeding spices..."

User.create(username: "William", password: "W1234")
User.create(username: "Linda", password: "L1234")
User.create(username: "Moses", password: "M1234")
User.create(username: "Clara", password: "C1234")

Room.create(room_name: "General", room_detail: "A place to discuss everything", locked: NULL)
Room.create(room_name: "Running", room_detail: "Go on one run per day", locked: NULL)
Room.create(room_name: "Health", room_detail: "Stop eating junk", locked: NULL)
Room.create(room_name: "Meditate", room_detail: "Mediatate at least 5 mins / day", locked: NULL)

sample_messages = ["Hello", "Whatsup", "Yo", "How are you doing", "OMG", "Hows it going?", "I'm so pumped to be here"]

Room.all.each do |current_room|
    4.times do
        Message.create(user_id: rand(1..4), room_id: current_room.id, message_text: sample_messages.sample )
    end
end





puts "✅ Done seeding!"
