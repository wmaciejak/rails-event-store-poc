class Reservation
  module Commands
    class Create < Command::Base
      attr_accessor :id
      attr_accessor :tickets_count
      attr_accessor :sector_id
      attr_accessor :requested_at
      attr_accessor :status

      alias :aggregate_id :id
    end
  end
end
