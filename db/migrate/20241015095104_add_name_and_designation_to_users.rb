class AddNameAndDesignationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :designation, :string, null: false
  end
end
