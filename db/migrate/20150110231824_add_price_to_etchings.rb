class AddPriceToEtchings < ActiveRecord::Migration
  def self.up
    add_column :etchings, :price, :integer
  end

  def self.down
    remove_column :etchings, :price
  end
end
