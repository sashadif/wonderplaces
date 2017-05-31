class CreatePlacesUsers < ActiveRecord::Migration
  def change
    create_table :places_users do |t|
      t.integer :place_id
      t.integer :user_id
    end
  end
end
