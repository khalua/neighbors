class CreateDemographicsTable < ActiveRecord::Migration
  def change
    create_table :binder do |t|
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
      t.timestamps
    end
  end
end
