class AddCodeToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :code, :string
    add_index :contents, :code, unique: true
  end
end
