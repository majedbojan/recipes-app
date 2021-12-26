# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.references :recipe, null: true, foreign_key: { on_delete: :nullify }, type: :uuid
      t.string :name, null: false

      t.timestamps

      t.index(%i[name recipe_id], unique: true)
    end
  end
end
