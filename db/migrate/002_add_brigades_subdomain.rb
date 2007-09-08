class AddBrigadesSubdomain < ActiveRecord::Migration
  def self.up
    add_column :brigades, :subdomain, :string
  end

  def self.down
    remove_column :brigades, :subdomain
  end
end
