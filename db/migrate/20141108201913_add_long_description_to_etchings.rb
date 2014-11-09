class AddLongDescriptionToEtchings < ActiveRecord::Migration
  # def change
  #   add_column :etchings, :long_description, :string
  #   add_column :etchings, :listed, :boolean
  # end

  def self.up
    add_column :etchings, :long_description, :string
    add_column :etchings, :listed, :boolean
    rename_column :etchings, :description, :short_description
  end

  def self.down
    remove_column :etchings, :long_description
    remove_column :etchings, :listed
    rename_column :etchings, :short_description, :description
  end

end
