class CreateBindersTable < ActiveRecord::Migration
  def change
    create_table :binders do |t|
      t.string  :name
      t.integer :person_id
      t.timestamps
    end
  end
end
