class AddFieldsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :h1, :string
    add_column :members, :h2, :string
    add_column :members, :h3, :string
  end
end
