class AddPrimaryLocationColumnToHolders < ActiveRecord::Migration[4.2]
  def up
	add_column :holder, :primary_mouse_location, :string
  end
  
  def down
    remove_column :holder, :primary_mouse_location
  end
end
