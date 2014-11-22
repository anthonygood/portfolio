class AddNotesToPrints < ActiveRecord::Migration
  def up
    add_column :prints, :notes, :text
  end

  def down
    remove_column :prints, :notes
  end
end
