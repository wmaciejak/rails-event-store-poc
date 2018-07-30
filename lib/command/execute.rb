module Command
  module Execute
    def execute(command)
      command.validate!
      handler_for(command).call(command)
    end

    private
    def handler_for(command)
      {
        Reservation::Commands::Create => Reservation::CommandHandlers::Create.new,
        Reservation::Commands::UpdateStatus => Reservation::CommandHandlers::UpdateStatus.new,
      }.fetch(command.class)
    end
  end
end
