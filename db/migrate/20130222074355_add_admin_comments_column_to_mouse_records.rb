class AddAdminCommentsColumnToMouseRecords < ActiveRecord::Migration[4.2]
  def up
    add_column :mouse, :admin_comment, :text
  end
  
  def down
    remove_column :admin_comment, :local_experts
  end
end