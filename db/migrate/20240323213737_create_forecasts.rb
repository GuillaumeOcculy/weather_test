class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.belongs_to :city, null: false, foreign_key: true
      t.date :date, null: false
      t.decimal :min_temperature, null: false, precision: 5, scale: 2
      t.decimal :max_temperature, null: false, precision: 5, scale: 2
      t.string :unit, null: false

      t.jsonb :response, null: false, default: {}

      t.timestamps
    end
  end
end
