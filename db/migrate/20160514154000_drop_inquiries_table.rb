class DropInquiriesTable < ActiveRecord::Migration
  def up
    drop_table :inquiries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
