class AddAvatarsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :avatars, :string
  end
end
