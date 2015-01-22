class ChangeLongDescriptionTypeToString < ActiveRecord::Migration
  def up
    change_column :etchings, :long_description,  :text
  end

  def down
    change_column :etchings, :long_description, :string
  end
end
