class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.column :title, :string
      t.column :short_description, :text
      t.column :description, :text
      t.column :resource_id, :integer
      t.column :resource_type, :string
    end
  end

  def self.down
    drop_table :properties
  end
end
