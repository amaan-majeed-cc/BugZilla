class AllowDeveloperIdToBeNullInTickets < ActiveRecord::Migration[7.2]
  def change
    change_column_null :tickets, :developer_id, true
  end
end
