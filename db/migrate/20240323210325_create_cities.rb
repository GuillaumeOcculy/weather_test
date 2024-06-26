class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :accu_weather_key, null: false

      t.timestamps
    end
  end
end
