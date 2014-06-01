class CreatePatientSocialAccount < ActiveRecord::Migration
  def change
    create_table :patient_social_accounts do |t|
      t.references  :patient, null: false
      t.string      :uuid, null: false
      t.string      :provider, null: false

      t.timestamps
    end
    add_index :patient_social_accounts, [:uuid, :provider], unique: true
  end
end
