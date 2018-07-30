class CreateSectors < ActiveRecord::Migration[5.0]
  def change
    create_table :sectors do |t|
      t.integer :tickets_count
      t.integer :available_tickets_count
    end
  end
end
