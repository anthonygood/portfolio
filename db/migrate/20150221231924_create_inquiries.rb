class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string  :name
      t.string  :email
      t.string  :phone
      t.text    :message
      t.integer :etching_id

      t.timestamps
    end
  end
end
