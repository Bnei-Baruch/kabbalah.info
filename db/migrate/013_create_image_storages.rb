class CreateImageStorages < ActiveRecord::Migration
  def self.up
    create_table :image_storages do |t|
      t.column :property_id, :integer
      t.column :parent_id, :integer
      t.column :content_type, :string
      t.column :filename, :string
      t.column :thumbnail, :string
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
    end
  end

  def self.down
    drop_table :image_storages
  end
end
