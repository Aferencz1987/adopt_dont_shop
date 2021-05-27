class AddColumnToPetsPetApp < ActiveRecord::Migration[5.2]
  def change
    change_table :pets_pet_apps do |t|
      t.string :status
    end
  end
end
