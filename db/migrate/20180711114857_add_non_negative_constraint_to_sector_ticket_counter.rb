class AddNonNegativeConstraintToSectorTicketCounter < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      ALTER TABLE sectors
      ADD CONSTRAINT non_negative_available_tickets_count
      CHECK (available_tickets_count >= 0)
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE sectors
      DROP CONSTRAINT non_negative_available_tickets_count
    SQL
  end
end
