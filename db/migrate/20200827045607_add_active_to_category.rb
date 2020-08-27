class AddActiveToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :active, :boolean, dafault: true
  end
end
