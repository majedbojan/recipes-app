# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name
    end
  end
end
