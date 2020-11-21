class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login
      t.string :fullname
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :role

      t.timestamps
    end
  end
end
