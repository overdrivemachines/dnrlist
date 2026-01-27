def create_guests
  50.times do
    Guest.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name,
                 dob: Faker::Date.birthday(min_age: 18, max_age: 65), reason: Faker::Company.bs, user_id: User.first.id)
  end
end

def create_users
  [
    { email: "a@a.com", password: "manager", display_name: "a", name: "a" },
    { email: "b@b.com", password: "manager", display_name: "b", name: "b" }
  ].each do |attrs|
    user = User.find_or_initialize_by(email: attrs[:email])
    user.assign_attributes(
      password: attrs[:password],
      password_confirmation: attrs[:password],
      display_name: attrs[:display_name],
      name: attrs[:name]
    )
    user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
    user.save!
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

create_users
create_guests_from_file
