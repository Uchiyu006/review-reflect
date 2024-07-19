10.times do |index|
  user = User.find(1)
  user.reviews.create!(title: "title#{index}", summary: "summary#{index}")
end