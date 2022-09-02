class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 100
      t.string :email, null: false, limit: 100, unique: true
      t.string :password_digest, null: false
      t.string :mobile, limit: 100

      t.timestamps
    end
  end
end
