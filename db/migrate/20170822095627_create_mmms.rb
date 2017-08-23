class CreateMmms < ActiveRecord::Migration[5.1]
  def change
    create_table :mmms do |t|

      t.timestamps
    end
  end
end
