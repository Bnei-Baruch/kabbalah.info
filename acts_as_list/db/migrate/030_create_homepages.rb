class CreateHomepages < ActiveRecord::Migration
  def self.up
    create_table :homepages do |t|
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :homepages
  end
end
