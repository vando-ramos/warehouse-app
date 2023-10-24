class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :nif
      t.string :address
      t.string :city
      t.string :state
      t.string :email

      t.timestamps
    end
  end
end
