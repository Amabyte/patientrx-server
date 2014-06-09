class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.references  :patient, null: false
      t.references  :docter
      t.string :name, null: false
      t.integer :age, null: false
      t.string :gender, null: false
      t.float :lat
      t.float :lag

      t.timestamps
    end
  end
end
