class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :grid, :default => 5
      t.text :data, :default => "[]"
      t.integer :score, :default => 0
      t.integer :free_size, :default => -1
      t.boolean :is_complete, :default => :false
      t.references :user, index: true

      t.timestamps
    end
  end
end
