class ChangeDateColumnToInteger < ActiveRecord::Migration

  def up
    remove_column :etchings, :date_created
    add_column :etchings, :year, :integer
  end

  def down
    add_column :etchings, :date_created, :date
    remove_column :etchings, :year
  end

end
