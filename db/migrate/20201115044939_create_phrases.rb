class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrases do |t|
      t.string :country
      t.string :original_language
      t.string :original_phrase
      t.string :translated_language
      t.string :translated_phrase

      t.timestamps
    end
  end
end
