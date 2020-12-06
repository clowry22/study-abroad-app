class AddUserIdToPhrases < ActiveRecord::Migration[6.0]
  def change
    add_column :phrases, :userid, :integer
  end
end
