class CreateRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :rankings do |t|
      t.integer :blogs, :user_id
      t.integer :users, :user_id

      t.timestamps
    end
  end
end
