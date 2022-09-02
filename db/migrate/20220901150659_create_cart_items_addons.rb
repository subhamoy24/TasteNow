class CreateCartItemsAddons < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items_addons do |t|
      t.references :cart_item, foreign_key: true, null: false
      t.references :addon, foreign_key: true, null: false
      t.timestamps
    end
  end
end
