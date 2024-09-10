class AddImageToForums < ActiveRecord::Migration[6.0]
  def change
    add_column :forums, :image, :string
  end
end
