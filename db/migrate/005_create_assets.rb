class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets, :force => true do |t|
      t.column :parent_id, :integer
      t.column :position, :integer
      t.column :section_id, :integer
      t.column :resource_id, :integer
      t.column :resource_type, :string
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :assets
  end
end
