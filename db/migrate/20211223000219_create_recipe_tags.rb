# frozen_string_literal: true

class CreateRecipeTags < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_tags, id: :uuid do |t|
      t.references :recipe, null: true, foreign_key: { on_delete: :nullify }, type: :uuid
      t.references :tag, null: true, foreign_key: { on_delete: :nullify }, type: :uuid
      t.timestamps
    end
  end
end
