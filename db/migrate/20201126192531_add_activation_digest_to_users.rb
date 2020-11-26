class AddActivationDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :activation_digest, :string
    add_index :users, :activation_digest
  end
end
