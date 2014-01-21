class AddShortWebsiteToMembers < ActiveRecord::Migration
  def change
    add_column :members, :short_website, :string
  end
end
