class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.string :title         , null: false
      t.integer :visibility   , null: false
      t.references :user      , null: false, foreign_key: true

      t.timestamps
    end
  end
end
