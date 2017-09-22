class AddImageToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :image, :string
    add_column :users, :image, :string
    add_column :users, :admin, :boolean, :default => false
  end
end
