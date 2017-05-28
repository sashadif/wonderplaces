class RemovePhotoFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :photo, :string
  end
end
