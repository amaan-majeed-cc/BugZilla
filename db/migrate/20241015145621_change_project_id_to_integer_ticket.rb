class ChangeProjectIdToIntegerTicket < ActiveRecord::Migration[7.2]
  def change
    change_column :tickets, :project_id, :integer
  end
end
