class UpdateDate < ActiveRecord::Migration
  def self.up
    rename_column :etchings, :date, :date_created
  end

  def self.down
    rename_column :etchings, :date_created, :date
  end
end
