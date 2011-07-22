class AddFieldsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :featured, :boolean, :default => false
    add_column :posts, :deleted, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :deleted
    remove_column :posts, :featured
  end
end
