def create_guests
  50.times do
    Guest.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name,
                 dob: Faker::Date.birthday(min_age: 18, max_age: 65), reason: Faker::Company.bs, user_id: User.first.id)
  end
end

def create_guests_from_file
  i = 1
  File.foreach(Rails.root.join('db', 'in.txt')) do |line|
    arr = line.strip.split(", ")
    puts(i.to_s + " " + arr.to_s) if arr.size != 2
    i += 1

    # puts arr.to_s

    Guest.create!(firstname: arr.last, lastname: arr.first, reason: "Not recorded", user_id: 2)
  end
end

create_guests_from_file
