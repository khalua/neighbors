class CreateBindersDemographicTable < ActiveRecord::Migration
  def change
    create_table :binders_demographics, :id => false do |t|
      t.integer :binder_id
      t.integer :demographic_id
    end
  end
end
