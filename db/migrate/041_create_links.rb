class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :link, :string
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :links
  end
end
