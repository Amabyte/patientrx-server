class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name, null: false
      t.string :qualifications
      t.string :specialisations

      t.timestamps
    end
  end
end
