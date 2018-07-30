class Reservation
  module Commands
    class UpdateStatus < Command::Base
      attr_accessor :id
      attr_accessor :status

      alias :aggregate_id :id
    end
  end
end
