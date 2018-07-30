Rails.configuration.event_store.tap do |event_store|
  event_store.subscribe(Reservation::Denormalizers::Created, to: [Reservation::Events::Created])
  event_store.subscribe(Sector::Denormalizers::UpdateAvailableTickets, to: [Reservation::Events::Created])
  event_store.subscribe(Reservation::Denormalizers::Update, to: [Reservation::Events::StatusChanged])
end
