class AddMedUrlToPrints < ActiveRecord::Migration
  def self.up
    add_column :prints, :medium_url, :string
  end

  def self.down
    remove_column :prints, :medium_url
  end
end
