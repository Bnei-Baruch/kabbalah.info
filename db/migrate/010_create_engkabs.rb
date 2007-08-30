class CreateEngkabs < ActiveRecord::Migration
  def self.up
    create_table :engkabs do |t|
    end
  end

  def self.down
    drop_table :engkabs
  end
end
