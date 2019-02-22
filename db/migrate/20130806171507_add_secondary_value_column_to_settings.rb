class AddSecondaryValueColumnToSettings < ActiveRecord::Migration[4.2]
  def up
	add_column :settings, :secondary_value, :string
  end
  
  def down
    remove_column :settings, :secondary_value
  end
end
