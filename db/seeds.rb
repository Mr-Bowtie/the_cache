3.times do |i|
  AdventureLog.create(title: "testing_#{i}", date: "#{Time.now}", content: '<p>Testing</p>')
end

3.times do |i|
  Location.create(name: "testing#{i}")
end

3.times do |i|
  Npc.create(name: "testing#{i}")
end
