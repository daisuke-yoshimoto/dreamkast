class CreateTalks < ActiveRecord::Migration[6.0]
  def change
    create_table :talks do |t|
      t.string :title
      t.text :abstract
      t.string :movie_url
      t.string :track
      t.time :start_time
      t.time :end_time
      t.belongs_to :talk_difficulty
      t.belongs_to :talk_category

      t.timestamps
    end
  end
end
