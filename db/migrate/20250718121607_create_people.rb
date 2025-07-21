class CreatePeople < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :aadhaar_number
      t.text :address
      t.string :phone

      t.timestamps
    end
  end
end
