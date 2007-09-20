class CreateRssFeeders < ActiveRecord::Migration
  def self.up
    create_table :rss_feeders do |t|
      t.column :url, :string
      t.column :number_of_items, :integer
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :rss_feeders
  end
end
