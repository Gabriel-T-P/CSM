class CreateAnnouncements < ActiveRecord::Migration[8.0]
  def change
    create_table :announcements do |t|
      t.string :title,       null: false
      t.string :body,        null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
