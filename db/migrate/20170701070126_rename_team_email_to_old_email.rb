class RenameTeamEmailToOldEmail < ActiveRecord::Migration[5.0]
  def change
    rename_column :teams, :email, :old_email
  end
end
