class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :host, limit: 20
      t.string :short_name, limit: 20
      t.string :name, limit: 20

      t.timestamps
    end

    add_index :shops, :host, unique: true
    add_index :shops, :name, unique: true
  end
end
