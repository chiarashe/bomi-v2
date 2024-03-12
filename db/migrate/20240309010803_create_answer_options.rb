class CreateAnswerOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :answer_options do |t|
      t.string :text
      t.references :answer, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
