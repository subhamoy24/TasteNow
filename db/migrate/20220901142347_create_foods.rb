class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string     :name, null: false
      t.text       :description
      t.decimal    :price, null: false, default: 0.0
      t.timestamps
    end
  end
end
