class CreateAddons < ActiveRecord::Migration[6.0]
  def change
    create_table :addons do |t|
      t.references :food, foreign_key: true, null: false
      t.string     :name, null: false
      t.text       :description
      t.decimal    :price, null: false, default: 0.0
      t.timestamps
    end
  end
end
