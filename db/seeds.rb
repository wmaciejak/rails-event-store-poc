# Create 1000 100-seat sectors

(1..1000).each do |i|
  Sector.create(id: i, tickets_count: 100, available_tickets_count: 100)
end
