class CreatePictires < ActiveRecord::Migration[5.1]
  def change
    create_table :pictires do |t|
      t.string :image

      t.timestamps
    end
  end
end
