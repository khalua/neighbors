class AddDescriptionToBinder < ActiveRecord::Migration
  def change
    change_table :binders do |t|
      t.text :description
    end
  end
end
