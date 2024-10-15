class ChangeDeadlineToDateInTickets < ActiveRecord::Migration[7.2]
  def change
    change_column :tickets, :deadline, :date
  end
end
