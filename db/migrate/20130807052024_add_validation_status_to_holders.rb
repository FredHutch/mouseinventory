class AddValidationStatusToHolders < ActiveRecord::Migration[4.2]
  def up
	add_column :holder, :validation_status, :string
  end
  
  def down
    remove_column :holder, :validation_status
  end
end
