class AddDefaultToListedProperty < ActiveRecord::Migration
  def self.up
    change_column :etchings, :listed, :boolean, :default => true
  end

  def self.down
    # You can't currently remove default values in Rails
    change_column :etchings, :listed, :boolean, :default => nil
  end
end
