class AddNoteColumnToDemographic < ActiveRecord::Migration
  def change
    change_table :demographics do |t|
      t.text  :note
    end
  end
end
