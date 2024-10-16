class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.text :title, null: false
      t.string :description
      t.date :deadline, null: false
      t.string :ticket_type, null: false
      t.string :status, null: false

      t.timestamps
    end
    add_index :tickets, :title, unique: true
  end
end
