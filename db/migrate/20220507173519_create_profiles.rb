class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :native_language
      t.string :target_language
      t.text :source

      t.timestamps
    end
  end
end
