class AddSubmissionSourceColumn < ActiveRecord::Migration[4.2]
  def up
    add_column :submittedmouse, :submission_source, :string, :limit => 255;
  end

  def down
    remove_column :submittedmouse, :submission_source
  end
end
