# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks, id: :uuid do |t|
      t.references :user, null: true, foreign_key: { on_delete: :nullify }, type: :uuid
      t.references :recipe, null: true, foreign_key: { on_delete: :nullify }, type: :uuid

      t.integer  :rating, null: false
      t.text     :comment

      t.timestamps null: false
      t.index :rating
      t.index :comment, where: 'comment IS NOT NULL'
    end
  end
end
