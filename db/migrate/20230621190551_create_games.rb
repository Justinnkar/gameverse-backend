class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.float :rating
      t.string :platform
      t.string :genre
      t.string :developer
      t.text :image
      t.string :summary
      t.string :text
      t.date :release_date

      t.timestamps
    end
  end
end
