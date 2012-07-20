class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands, force: true do |t|
      t.string :name, limit: 30
      t.string :url,  limit: 30
      t.text   :description
    end
  end
end
