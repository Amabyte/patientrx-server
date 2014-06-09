class CreateCaseComments < ActiveRecord::Migration
  def change
    create_table :case_comments do |t|
      t.references  :case, null: false
      t.string :who, null: false
      t.references  :docter
      t.text :message
      t.string :image
      t.string :audio
      t.boolean :is_new, default: true

      t.timestamps
    end
  end
end
