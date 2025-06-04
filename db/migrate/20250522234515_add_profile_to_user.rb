class AddProfileToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :birth_date, :date
    add_column :users, :biography, :string
    add_column :users, :gender, :integer
    add_column :users, :location, :string
  end
end
