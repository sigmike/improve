class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :title
      t.datetime :start
      t.datetime :stop
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
