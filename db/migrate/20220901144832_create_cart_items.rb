class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references  :cart, null: false, foreign_key: true
      t.references  :variation, foreign_key: true
      t.references  :food, foreign_key: true
      t.integer     :quantity, null: false, default: 1
      t.timestamps
    end
  end
end
