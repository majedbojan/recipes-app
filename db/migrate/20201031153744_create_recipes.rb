# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.references :user, null: true, foreign_key: { on_delete: :nullify }, type: :uuid

      t.integer :status,     null: false, default: 1
      t.integer :budget,     null: false
      t.integer :difficulty, null: false
      t.integer :people_quantity

      t.string  :name,        null: false
      t.string  :prep_time,   null: false
      t.string  :cook_time,   null: false
      t.string  :image_url

      t.timestamps

      t.index :status
    end
  end
end
