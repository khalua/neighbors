class CreateDemographicsTable < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.string  :state
      t.string  :city
      t.float   :household_income
      t.float   :single_family_home
      t.float   :single_males
      t.float   :single_females
      t.integer :median_age
      t.float   :homes_with_kids
      t.float   :owners
      t.float   :renters
      t.float   :latitude
      t.float   :longitude
      t.integer :binder_id
      t.timestamps
    end
  end
end
