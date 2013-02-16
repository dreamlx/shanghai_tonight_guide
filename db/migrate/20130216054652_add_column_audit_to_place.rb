class AddColumnAuditToPlace < ActiveRecord::Migration
  def change
    add_column :places, :audit, :boolean, :default => false
  end
end
