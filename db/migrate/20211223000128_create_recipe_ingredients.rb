# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingredients, id: :uuid do |t|
      t.references :recipe, null: true, foreign_key: { on_delete: :nullify }, type: :uuid
      t.references :ingredient, null: true, foreign_key: { on_delete: :nullify }, type: :uuid

      t.timestamps
    end
  end
end
