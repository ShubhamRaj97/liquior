class AddUuidToStoresAndPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :stores, :uuid, :uuid, default: -> { "uuid_generate_v4()" }, null: false
    add_column :people, :uuid, :uuid, default: -> { "uuid_generate_v4()" }, null: false
  end
end
