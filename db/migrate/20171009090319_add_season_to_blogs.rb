class AddSeasonToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :season, :string
  end
end
