class CreatePlaceholders < ActiveRecord::Migration
  def self.up
    create_table :placeholders do |t|
      t.column :name, :string
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :placeholders
  end
end
