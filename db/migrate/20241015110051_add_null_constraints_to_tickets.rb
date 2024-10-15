class AddNullConstraintsToTickets < ActiveRecord::Migration[7.2]
  def change
    change_column_null :tickets, :title, false
    change_column_null :tickets, :deadline, false
    change_column_null :tickets, :ticket_type, false
    change_column_null :tickets, :status, false
    change_column_null :tickets, :creator, false
    change_column_null :tickets, :developer, false
    change_column_null :tickets, :project_id, false
  end
end
