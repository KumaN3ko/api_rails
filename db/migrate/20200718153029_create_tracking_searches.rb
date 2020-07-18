class CreateTrackingSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :tracking_searches do |t|
      t.numeric :user
      t.text :search

      t.timestamps
    end
  end
end
