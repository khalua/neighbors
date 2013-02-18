class DropBinderidFromDemographics < ActiveRecord::Migration
  def change
    change_table :demographics do |t|
      t.remove :binder_id
    end
  end
end
