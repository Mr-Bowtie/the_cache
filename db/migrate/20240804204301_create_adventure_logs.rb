class CreateAdventureLogs < ActiveRecord::Migration[7.1]
  def change
    create_table(:adventure_logs) do |t|
      t.string :title
      t.datetime :date, null: false
      t.integer :session_number
      t.string :content
    end
  end
end
