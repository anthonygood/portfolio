class CreatePrints < ActiveRecord::Migration
  def change
    create_table :prints do |t|
      t.string :thumbnail_url
      t.string :large_url
      t.string :tags
      t.references :etching, index: true

      t.timestamps
    end
  end
end
