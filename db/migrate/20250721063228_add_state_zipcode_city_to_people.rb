class AddStateZipcodeCityToPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :people, :state, :string
    add_column :people, :city, :string
    add_column :people, :zip_code, :string
    add_column :people, :user_id, :integer
    add_column :people, :created_by, :string
  end
end
