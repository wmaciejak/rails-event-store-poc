class Reservation
  class Aggregate
    include AggregateRoot

    REQUEST_TTL = 1.minute

    TimeOut = Class.new(StandardError)

    def initialize(id)
      @id = id
    end

    def create(object)
      raise TimeOut if Time.zone.now.to_i - object.requested_at > REQUEST_TTL
      apply Events::Created.new(data: {
          id: object.id,
          sector_id: object.sector_id,
          status: "requested",
          tickets_count: object.tickets_count,
          requested_at: object.requested_at,
        }
      )
    end

    def update_status(object)
      apply Events::StatusChanged.new(data: {
          id: object.id,
          status: object.status
        }
      )
    end

    attr_reader :id

    private

    attr_accessor :sector_id, :status, :tickets_count, :requested_at

    def apply_created(event)
      @sector_id = event.data[:sector_id]
      @status = event.data[:status]
      @tickets_count = event.data[:tickets_count]
      @requested_at = event.data[:requested_at]
    end

    def apply_status_changed(event)
      @status = event.data[:status]
    end
  end
end
