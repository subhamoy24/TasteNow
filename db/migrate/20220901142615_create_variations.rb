class CreateVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :variations do |t|
      t.references :food, foreign_key: true, null: false
      t.string     :name,  null: false
      t.decimal    :price, null: false, default: 0.0
      t.text       :description
      t.timestamps
    end
  end
end
