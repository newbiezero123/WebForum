class RemoveImageFromForums < ActiveRecord::Migration[7.2]
  def change
    remove_column :forums, :image, :string
  end
end
