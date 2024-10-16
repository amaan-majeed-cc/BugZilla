class AddCreatorToTickets < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :creator, null: false, foreign_key: { to_table: :users }
    add_reference :tickets, :developer, null: false, foreign_key: { to_table: :users }
    add_reference :tickets, :project, null: false, foreign_key: { to_table: :projects }
  end
end
