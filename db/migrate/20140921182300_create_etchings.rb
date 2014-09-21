class CreateEtchings < ActiveRecord::Migration
  def change
    create_table :etchings do |t|
      t.string :title
      t.text :description
      t.integer :height
      t.integer :width
      t.string :large_img_url
      t.string :thumbnail_url
      t.integer :plates
      t.integer :print_run
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
