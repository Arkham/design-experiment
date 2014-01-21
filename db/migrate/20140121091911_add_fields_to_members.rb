class AddFieldsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :h1, :text
    add_column :members, :h2, :text
    add_column :members, :h3, :text
  end
end
