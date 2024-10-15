class RenameTypeColumnToTicketTypeOnTickets < ActiveRecord::Migration[7.2]
  def change
    rename_column :tickets, :ticket_type, :ticket_type
  end
end
