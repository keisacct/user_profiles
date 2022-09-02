class CreateStayedCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :stayed_countries do |t|

      t.references :user, null: false, foreign_key: true
      t.integer :country_id, null: false

      t.timestamps
    end
  end
end
