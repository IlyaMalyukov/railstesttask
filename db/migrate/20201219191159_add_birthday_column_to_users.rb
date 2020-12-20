class AddBirthdayColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column  :users, :birthday, :string
  end
end
