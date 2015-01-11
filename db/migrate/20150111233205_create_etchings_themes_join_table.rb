class CreateEtchingsThemesJoinTable < ActiveRecord::Migration
  def self.up
    create_table :etchings_themes, :id => false do |t|
      t.integer :etching_id
      t.integer :theme_id
    end

    add_index :etchings_themes, [:etching_id, :theme_id]
  end

  def self.down
    drop_table :etchings_themes
  end
end
