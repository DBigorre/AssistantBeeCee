class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.boolean :linked
      t.references :link, null: false, foreign_key: true
      t.string :query

      t.timestamps
    end
  end
end
