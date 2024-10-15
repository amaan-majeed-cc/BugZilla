class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.text :title
      t.string :description
      t.date :deadline
      t.string :ticket_type
      t.string :status
      t.string :creator
      t.string :developer
      t.string :project_id

      t.timestamps
    end
    add_index :tickets, :title, unique: true
  end
end
